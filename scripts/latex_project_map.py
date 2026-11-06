#!/usr/bin/env python3
"""Conservative LaTeX project discovery. Emits JSON; does not expand TeX macros."""
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path


IGNORED = {'.git', '.agents', '.claude', '.codex', '.pi', 'node_modules'}


def source_text(text: str) -> str:
    """Mask comments and common verbatim regions, retaining line numbers."""
    def mask(match):
        return re.sub(r'[^\n]', ' ', match[0])
    text = re.sub(r'\\begin\{(verbatim\*?|lstlisting|minted|comment)\}.*?\\end\{\1\}', mask, text, flags=re.S)
    text = re.sub(r'\\verb\*?([^\w\s]).*?\1', mask, text)
    return '\n'.join(
        strip_comment(line) for line in text.split('\n'))


def strip_comment(line: str) -> str:
    for i, char in enumerate(line):
        if char == '%' and (len(line[:i]) - len(line[:i].rstrip('\\'))) % 2 == 0:
            return line[:i]
    return line


def discover(root: Path, entry: str | None = None, fls: str | None = None) -> dict:
    root = root.resolve()
    if not root.is_dir():
        raise ValueError('root must be a directory')
    def relative(path):
        return path.relative_to(root).as_posix()
    def local(path):
        return path.resolve().is_relative_to(root)
    candidates = []
    for path in sorted(root.rglob('*.tex')):
        if not IGNORED.intersection(path.relative_to(root).parts) and local(path):
            if re.search(r'\\documentclass\b', source_text(path.read_text(errors='replace'))):
                candidates.append(relative(path))
    if entry is None and len(candidates) == 1:
        entry = candidates[0]
    report = dict(schema_version=1, candidates=candidates, entry=entry, active_files=[],
                  dependencies=[], bibliography_files=[], macro_files=[], macro_definitions=[],
                  command_candidates=[], graphics=[], document_class=None, engine=None,
                  bibliography_backend=None, build_metadata=[], limitations=[], recorder_status='not_used')
    for name in ('Makefile', 'makefile', '.latexmkrc', 'latexmkrc'):
        if (root / name).is_file():
            report['build_metadata'].append(name)
    report['limitations'].append('Static scan does not expand macros, conditionals, includeonly, or TeX search paths; confirm active files and command semantics.')
    if entry is None:
        report['limitations'].append('Entry point unresolved: supply --entry; no active manuscript selected.')
        return report
    main = (root / entry).resolve()
    if not local(main) or not main.is_file():
        raise ValueError('entry must be an existing file inside root')
    entry = relative(main)
    report['entry'] = entry
    pending = [main]
    recorder_inputs = None
    visited = set()
    # Recorder is a build snapshot, not an inferred parent/child graph.
    if fls:
        recorder = root / fls
        if not recorder.is_file():
            raise ValueError(f'missing recorder: {fls}')
        inputs = []
        pwd = root
        for line in recorder.read_text(errors='replace').splitlines():
            if line.startswith('PWD '):
                pwd = Path(line[4:])
            elif line.startswith('INPUT '):
                path = (pwd / line[6:]).resolve()
                if local(path) and path.suffix in ('.tex', '.sty', '.cls', '.bib'):
                    inputs.append(path)
        valid = (main in inputs and all(p.is_file() and p.stat().st_mtime_ns <= recorder.stat().st_mtime_ns for p in inputs))
        if valid:
            report['recorder_status'] = 'accepted_snapshot'
            recorder_inputs = set(inputs)
            pending += [p for p in inputs if p.suffix != '.bib']
            report['bibliography_files'] += [relative(p) for p in inputs if p.suffix == '.bib']
            report['limitations'].append('Recorder freshness checked against listed local inputs only; build provenance and omitted/new inputs still require confirmation.')
        else:
            report['recorder_status'] = 'rejected_stale_or_unrelated'
            report['limitations'].append('Recorder rejected; using source scan.')
    while pending:
        path = pending.pop(0)
        if path in visited:
            continue
        visited.add(path)
        name = relative(path)
        report['active_files'].append(name)
        raw = path.read_text(errors='replace')
        text = source_text(raw)
        if path == main:
            cls = re.search(r'\\documentclass(?:\s*\[[^\]]*\])?\s*\{([^}]+)\}', text)
            report['document_class'] = cls[1] if cls else None
            engine = re.search(r'^\s*%\s*!\s*TeX\s+program\s*=\s*(\S+)', raw, re.M | re.I)
            report['engine'] = engine[1] if engine else None
        for match in re.finditer(r'\\(input|include|subfile|bibliography|addbibresource)\s*(?:\[[^\]]*\])?\s*\{([^}]+)\}', text):
            command, value = match.groups()
            bib = command in ('bibliography', 'addbibresource')
            for target in value.split(',') if bib else [value]:
                target = target.strip()
                edge = dict(file=name, line=text[:match.start()].count('\n') + 1, command=command, target=target)
                if re.search(r'[\\#{}]', target):
                    edge['status'] = 'dynamic_unresolved'
                else:
                    suffix = '.bib' if bib else '.tex'
                    target = target if Path(target).suffix else target + suffix
                    options = list(dict.fromkeys((root / target, path.parent / target)))
                    found = [p.resolve() for p in options if p.is_file() and local(p)]
                    if len(set(found)) > 1:
                        edge['status'] = 'ambiguous'
                    elif found:
                        resolved = found[0]
                        edge.update(status='found', resolved=relative(resolved))
                        if bib:
                            report['bibliography_files'].append(relative(resolved))
                        elif recorder_inputs is None or resolved in recorder_inputs:
                            pending.append(resolved)
                        else:
                            edge['status'] = 'not_in_recorder_snapshot'
                    else:
                        edge['status'] = 'missing_or_external'
                report['dependencies'].append(edge)
        definitions = list(re.finditer(r'\\(?:newcommand|renewcommand|providecommand|DeclareRobustCommand)\*?\s*\{?\\([A-Za-z@]+)|\\def\s*\\([A-Za-z@]+)', text))
        if definitions:
            report['macro_files'].append(name)
        for match in definitions:
            report['macro_definitions'].append(dict(name=next(g for g in match.groups() if g), file=name, line=text[:match.start()].count('\n') + 1))
        report['command_candidates'] += re.findall(r'\\([A-Za-z@]*(?:cite|ref)[A-Za-z@]*)\b', text, re.I)
        report['graphics'] += re.findall(r'\\includegraphics(?:\[[^\]]*\])?\{([^}]+)\}', text)
        if re.search(r'\\usepackage(?:\[[^\]]*\])?\{[^}]*biblatex', text):
            backend = re.search(r'backend\s*=\s*(\w+)', text)
            report['bibliography_backend'] = backend[1] if backend else 'biber (biblatex default; confirm)'
        elif re.search(r'\\bibliography\b', text) and report['bibliography_backend'] is None:
            report['bibliography_backend'] = 'bibtex (source evidence; confirm)'
    for key in ('active_files', 'bibliography_files', 'macro_files', 'command_candidates', 'graphics'):
        report[key] = sorted(set(report[key]))
    return report


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=Path('.'))
    parser.add_argument('--entry', help='Confirmed entry relative to root; otherwise only a unique candidate is selected')
    parser.add_argument('--fls', help='Recorder snapshot relative to root; rejects stale/missing/unrelated local inputs')
    parser.add_argument('--output', type=Path, help='JSON destination; otherwise stdout')
    args = parser.parse_args(argv)
    try:
        result = discover(args.root, args.entry, args.fls)
        data = json.dumps(result, indent=2, sort_keys=True) + '\n'
        if args.output:
            args.output.write_text(data)
        else:
            print(data, end='')
        return 0
    except (OSError, ValueError) as exc:
        print(json.dumps({'error': str(exc)}), file=sys.stderr)
        return 2


if __name__ == '__main__':
    raise SystemExit(main())
