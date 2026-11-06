#!/usr/bin/env python3
"""Build or parse LaTeX diagnostics; see --help. No third-party dependencies."""
from __future__ import annotations

import argparse
import json
import re
import shutil
import subprocess
import sys
from pathlib import Path


RULES = (
    ('fatal', 'error', r'^!|Emergency stop|Fatal error occurred|^.+?:\d+: (?:.*Error|Undefined control sequence|Missing |Extra |Misplaced |Runaway argument)'),
    ('undefined_citation', 'warning', r'Citation .*undefined|There were undefined citations'),
    ('undefined_reference', 'warning', r'Reference .*undefined|There were undefined references'),
    ('duplicate_label', 'warning', r'Label .*multiply defined|There were multiply-defined labels'),
    ('overfull_box', 'warning', r'Overfull \\[hv]box'),
    ('underfull_box', 'warning', r'Underfull \\[hv]box'),
    ('package_warning', 'warning', r'(?:Package|Class|LaTeX|LaTeX Font) .*Warning:|^LaTeX Warning:'),
)


def extract(text: str, source: str) -> list[dict]:
    """Conservative line extraction, retaining log location when TeX file is unknown."""
    findings = []
    for number, line in enumerate(text.splitlines(), 1):
        for category, severity, pattern in RULES:
            if re.search(pattern, line):
                location = re.match(r'(.+?\.(?:tex|sty|cls)):(\d+):', line)
                findings.append(dict(category=category, severity=severity,
                                     file=location[1] if location else None,
                                     line=int(location[2]) if location else None,
                                     source=source, source_line=number, evidence=line.strip()))
                break
    return findings


def identity(item: dict) -> tuple:
    return tuple(item.get(k) for k in ('category', 'file', 'line', 'evidence'))


def compare(report: dict, baseline: dict | None) -> None:
    report['baseline_status'] = 'not_compared'
    if baseline is None:
        return
    if (not isinstance(baseline, dict) or baseline.get('schema_version') != 1
            or not isinstance(baseline.get('diagnostics'), list)
            or not all(isinstance(item, dict) and 'category' in item and 'evidence' in item for item in baseline['diagnostics'])
            or baseline.get('scope') != report['scope']):
        raise ValueError('baseline must be a version 1 report with matching scope')
    known = {identity(item) for item in baseline['diagnostics']}
    report['baseline_status'] = 'compared'
    for item in report['diagnostics']:
        item['baseline'] = 'existing' if identity(item) in known else 'new'


def run(command, root: Path, timeout: int, shell=False):
    result = subprocess.run(command, cwd=root, shell=shell, text=True,
                            stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=timeout)
    return result.returncode, result.stdout


def main(argv=None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=Path('.'), help='Build working directory')
    parser.add_argument('--entry', help='Entry point relative to root; required for latexmk fallback')
    parser.add_argument('--build-command', help='Trusted project shell command; authoritative, executed only with --build')
    parser.add_argument('--build', action='store_true', help='Execute configured command or latexmk fallback')
    parser.add_argument('--engine', choices=['pdflatex', 'xelatex', 'lualatex', 'latex'], default=None,
                        help='Required for fallback; never overrides a project command')
    parser.add_argument('--backend', choices=['auto', 'bibtex', 'biber', 'none'], default='auto',
                        help='Recorded selection; latexmk detects backend from source/auxiliary files')
    parser.add_argument('--log', action='append', default=[], help='Actual log/output path relative to root; repeatable')
    parser.add_argument('--pdf', help='Expected PDF path relative to root')
    parser.add_argument('--chktex', action='append', default=[], metavar='TEX', help='Lint explicit active file; repeatable')
    parser.add_argument('--baseline', type=Path, help='Previous JSON report with identical scope; never updated')
    parser.add_argument('--output', type=Path, help='JSON destination; otherwise stdout')
    parser.add_argument('--timeout', type=int, default=180)
    parser.add_argument('--summary', action='store_true', help='Human summary on stderr')
    args = parser.parse_args(argv)
    try:
        root = args.root.resolve()
        if not root.is_dir() or args.timeout <= 0:
            raise ValueError('root must be a directory and timeout must be positive')
        if not args.build and not args.log:
            raise ValueError('provide --build or at least one --log')
        for name in ([args.entry] if args.entry else []) + args.chktex:
            if not (root / name).is_file():
                raise ValueError(f'missing source: {name}')
        scope = dict(entry=args.entry, command=args.build_command, engine=args.engine,
                     backend=args.backend, logs=args.log, chktex=args.chktex)
        report = dict(schema_version=1, scope=scope, build_status='not_run', build_returncode=None,
                      lint_status='not_run', lint_runs=[], diagnostics=[], logs=[], limitations=[])
        # Existing logs are not silently attributed to this build.
        before = {name: (root / name).stat().st_mtime_ns if (root / name).exists() else None for name in args.log}
        if args.build:
            if args.build_command:
                command = args.build_command
            else:
                if not args.entry or not args.engine:
                    raise ValueError('fallback needs confirmed --entry and --engine')
                mode = {'pdflatex': '-pdf', 'xelatex': '-xelatex', 'lualatex': '-lualatex', 'latex': '-pdfps'}[args.engine]
                command = ['latexmk', mode, '-interaction=nonstopmode', '-file-line-error', '-recorder']
                if args.backend == 'none':
                    command.append('-bibtex-')
                elif args.backend != 'auto':
                    report['limitations'].append(f'Requested {args.backend}: latexmk selects the actual backend from project source/configuration; verify agreement in build output.')
                command.append(args.entry)
            code, output = run(command, root, args.timeout, shell=bool(args.build_command))
            report['build_returncode'] = code
            report['build_status'] = 'pass' if code == 0 else 'fail'
            report['diagnostics'] += extract(output, 'build_output')
            report['build_output'] = output
            report['limitations'].append('Build output may contain intermediate-pass warnings; use the verified final log to determine which remain unresolved.')
        for name in args.log:
            path = root / name
            if not path.is_file():
                report['limitations'].append(f'missing log: {name}')
                report['logs'].append(dict(path=name, status='missing', diagnostic_count=None))
                continue
            if args.build and before[name] == path.stat().st_mtime_ns:
                report['limitations'].append(f'unchanged log (may be cached/stale): {name}')
            findings = extract(path.read_text(errors='replace'), name)
            report['diagnostics'] += findings
            freshness = ('unchanged' if before[name] == path.stat().st_mtime_ns else 'updated') if args.build else 'not_checked'
            report['logs'].append(dict(path=name, status='read', freshness=freshness, diagnostic_count=len(findings)))
        if args.chktex:
            if not shutil.which('chktex'):
                report['lint_status'] = 'unavailable'
            else:
                report['lint_status'] = 'pass'
                for name in args.chktex:
                    code, output = run(['chktex', '-q', '-f%f:%l:%c:%k:%n:%m\n', name], root, args.timeout)
                    report['lint_runs'].append(dict(file=name, returncode=code))
                    lint_error = code not in (0, 2)
                    for line in output.splitlines():
                        match = re.match(r'(.+?):(\d+):(\d+):([^:]*):(\d+):(.*)', line)
                        severity = 'error' if match and match[4].lower() == 'error' else 'warning'
                        lint_error = lint_error or severity == 'error'
                        report['diagnostics'].append(dict(category='chktex', severity=severity,
                            file=match[1] if match else name, line=int(match[2]) if match else None,
                            source='chktex', source_line=None, evidence=line))
                    if lint_error:
                        report['lint_status'] = 'error'
                    elif (output.strip() or code) and report['lint_status'] != 'error':
                        report['lint_status'] = 'warnings'
        report['pdf_status'] = ('present' if (root / args.pdf).is_file() else 'missing') if args.pdf else 'not_checked'
        if args.build and any(d['category'] == 'fatal' and d['source'] == 'build_output' for d in report['diagnostics']):
            report['build_status'] = 'fail'
        compare(report, json.loads(args.baseline.read_text()) if args.baseline else None)
        data = json.dumps(report, indent=2, sort_keys=True) + '\n'
        if args.output:
            args.output.write_text(data)
        else:
            print(data, end='')
        if args.summary:
            print(f"Build: {report['build_status']}; lint: {report['lint_status']}; diagnostics: {len(report['diagnostics'])}; baseline: {report['baseline_status']}", file=sys.stderr)
        return 1 if report['build_status'] == 'fail' else 0
    except (OSError, ValueError, TypeError, subprocess.TimeoutExpired) as exc:
        print(json.dumps(dict(schema_version=1, error=str(exc), build_status='unverified')), file=sys.stderr)
        return 2


if __name__ == '__main__':
    raise SystemExit(main())
