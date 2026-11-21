# Thesis build settings. VimTeX reads $out_dir and derives the engine from
# $pdf_mode, overriding the editor defaults. The Makefile passes -outdir itself.
$out_dir = 'build';
$pdf_mode = 4;  # LuaLaTeX: dissertation.cls and propositions.cls are LuaLaTeX-only

# \include{dir/file} writes dir/file.aux under the aux directory, and LaTeX
# cannot create that subdirectory itself. Create it before every LaTeX run,
# so builds into any -outdir work (the Makefile does the same with mkdir -p).
use File::Path qw(make_path);
sub make_include_dirs {
    my %dirs;
    for my $tex (glob('*.tex')) {
        open(my $fh, '<', $tex) or next;
        while (my $line = <$fh>) {
            $line =~ s/(?<!\\)%.*//;  # skip commented-out \include lines
            while ($line =~ /\\include\{([^}]*)\}/g) {
                my $path = $1;
                $dirs{$1} = 1 if $path =~ m{^(.*)/[^/]*$};
            }
        }
        close($fh);
    }
    my $base = $aux_dir ne '' ? $aux_dir : ($out_dir ne '' ? $out_dir : '.');
    make_path(map { "$base/$_" } keys %dirs);
}
sub latex_with_include_dirs {
    make_include_dirs();
    return system(@_);
}
$pdflatex = 'internal latex_with_include_dirs pdflatex %O %S';
$xelatex  = 'internal latex_with_include_dirs xelatex %O %S';
$lualatex = 'internal latex_with_include_dirs lualatex %O %S';

# Glossaries: let latexmk run makeglossaries whenever the .acn/.glo input
# changes, and rerun LaTeX afterwards, so the acronym list is never one build
# behind. Follows latexmk's glossaries example (example_rcfiles/glossary_latexmkrc).
add_cus_dep('acn', 'acr', 0, 'makeglossaries');
add_cus_dep('glo', 'gls', 0, 'makeglossaries');
$clean_ext .= ' acr acn alg glo gls glg';
sub makeglossaries {
    my ($base, $path) = fileparse($_[0]);
    return system('makeglossaries', '-d', $path, $base);
}
