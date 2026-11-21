\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dissertation}[2018/11/13 v2.0 TU Delft dissertation class by MB]
%% Changes over the 2013/07/08 v1.0 TU Delft dissertation class by Moritz Beller, moritzbeller -AT- gmx -DOT- de

\newif\if@print
\DeclareOption{print}{\@printtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

\LoadClass[10pt]{book}

%% Import packages
\RequirePackage{fontawesome7}
\RequirePackage{amsmath}
%% amssymb before unicode-math: later loads (e.g. pddl/config/preamble.tex) are then
%% no-ops instead of clashing with unicode-math symbols such as \eth.
\RequirePackage{amssymb}

%% English is the default language, but Dutch is used for some sections.
\RequirePackage[dutch,english]{babel}
\RequirePackage{calc}
\RequirePackage[nooneline,footnotesize]{caption}
%\RequirePackage{chapterbib}
\RequirePackage{etaremune}
\RequirePackage{fancyhdr}
\RequirePackage[flushmargin,hang,bottom]{footmisc}
%% The class is compiled with LuaLaTeX only.
\RequirePackage{geometry}
\RequirePackage[bookmarksnumbered]{hyperref}
\RequirePackage{bookmark}
\RequirePackage{fontspec}
\defaultfontfeatures{Ligatures=TeX}
\RequirePackage{lettrine}
\RequirePackage{csquotes}
\RequirePackage[backend=biber,style=numeric-comp,sorting=none,natbib=true,
    doi=true,url=false,isbn=false,eprint=false,maxbibnames=99]{biblatex}
\AtEveryBibitem{\clearlist{language}}
\RequirePackage[noindentafter]{titlesec}
\RequirePackage{titletoc}
%\RequirePackage[nottoc]{tocbibind}
\RequirePackage[dvipsnames,svgnames,table,xcdraw]{xcolor}
%\RequirePackage[table]{xcolor}
\RequirePackage{tikz}

%% Fonts from TeX Live: Libertinus (text and math) and Inconsolata (monospace).
\RequirePackage{unicode-math}

\setmainfont{LibertinusSerif}[Extension=.otf, UprightFont=*-Regular, ItalicFont=*-Italic, BoldFont=*-Bold, BoldItalicFont=*-BoldItalic]
\setsansfont{LibertinusSans}[Extension=.otf, UprightFont=*-Regular, ItalicFont=*-Italic, BoldFont=*-Bold]
\setmathfont{LibertinusMath-Regular.otf}
\setmonofont{Inconsolatazi4}[Extension=.otf, UprightFont=*-Regular, BoldFont=*-Bold, Scale=MatchLowercase]
%\renewcommand*\familydefault{\sfdefault}
\def\titlefont{\rmfamily}
\def\titleshape{}
\if@print
    \def\titlestyle{\titlefont\titleshape}
    %\def\titlestyle{\titlefont\titleshape\bfseries}
\else
    \def\titlestyle{\titlefont\titleshape}
\fi
\def\headerstyle{\titlestyle}

\RequirePackage[noabbrev]{cleveref}
\Crefname{enumi}{Step}{Steps}
\crefname{enumi}{step}{steps}

\RequirePackage{tabularx}

\RequirePackage{array}






\RequirePackage{microtype}
\RequirePackage{multirow}

\definecolor{light-gray}{gray}{0.95}
\definecolor{mgreen}{HTML}{009901}

%% Code listings with piton (LuaLaTeX). Captioned listings are "Example" floats
%% (the listing environment, numbered per chapter), also usable with \captionof.
\RequirePackage{piton}
\PitonOptions{
    font-command     = \ttfamily\footnotesize,
    background-color = light-gray,
    rounded-corners,
    break-lines,
    left-margin      = auto,
}
\RequirePackage{newfloat}
\DeclareFloatingEnvironment[name=Example, listname={List of Examples},
    fileext=lol, within=chapter, placement=tbp]{listing}
\crefname{listing}{Example}{Examples}
\Crefname{listing}{Example}{Examples}

% *** GRAPHICS RELATED PACKAGES ***
%
\RequirePackage{placeins}
%% Float-only pages: stack floats from the top with normal gaps instead of spreading
%% them over the whole page (the LaTeX default stretches \@fptop and \@fpsep).
\setlength{\@fptop}{0pt}
\setlength{\@fpsep}{12pt plus 4pt}


\RequirePackage{enumitem}
%% \setlist{before=\setlength{\rightmargin}{0.17cm}}

%% \setlist[enumerate]{
%%   nolistsep,label=\arabic{*}),ref=\arabic{*},leftmargin=0.65cm,noitemsep
%% }

%% \setlist[itemize]{
%%   nolistsep,label=\arabic{*}),ref=\arabic{*},noitemsep
%% }

\newlist{rqlist}{itemize}{2}
\setlist[rqlist]{
  nolistsep,leftmargin=1.65cm,rightmargin=0.9cm
}


\RequirePackage{booktabs}
\RequirePackage{tcolorbox}

\renewcommand*{\UrlFont}{\ttfamily\relax}





\RequirePackage{algorithm}
\RequirePackage{algpseudocode}
\newcommand{\var}[1]{{\ttfamily#1}}% variable

\newcommand{\ahref}[2]{\href{#1}{\nolinkurl{#2}}}
% number circles. They go well together with my favorite way of
% labeling stuff in pictures.
\newcommand\circled[1]{\raisebox{1.2pt}{\textcircled{\hspace{0.33pt}\scriptsize{\raisebox{-.1pt}{#1}}}}}


\RequirePackage[nomain,acronym,nonumberlist,style=list,postdot]{glossaries-extra} % nomain, if you define glossaries in a file, and you use \include{INP-00-glossary}
%% Keep the glossaries package behaviour for \newacronym: "long (short)" on first use.
\setabbreviationstyle[acronym]{long-short}

%% Stop importing packages


% Advanced Hyphenation
\clubpenalty=1000
\widowpenalty=1000

%% Define the TU Delft house style colors.
\definecolor{tudelft-cyan}{cmyk}{1,0,0,0}
\definecolor{tudelft-black}{cmyk}{0,0,0,1}
\definecolor{tudelft-white}{cmyk}{0,0,0,0}
\definecolor{tudelft-sea-green}{cmyk}{0.54,0,0.32,0}
\definecolor{tudelft-green}{cmyk}{1,0.15,0.4,0}
\definecolor{tudelft-dark-blue}{cmyk}{1,0.66,0,0.4}
\definecolor{tudelft-purple}{cmyk}{0.98,1,0,0.35}
\definecolor{tudelft-turquoise}{cmyk}{0.82,0,0.21,0.08}
\definecolor{tudelft-sky-blue}{cmyk}{0.45,0,0.06,0.06}
\definecolor{tudelft-lavendel}{cmyk}{0.45,0.2,0,0.07}
\definecolor{tudelft-orange}{cmyk}{0.02,0.56,0.84,0}
\definecolor{tudelft-warm-purple}{cmyk}{0.58,1,0,0.02}
\definecolor{tudelft-fuchsia}{cmyk}{0.19,1,0,0.19}
\definecolor{tudelft-bright-green}{cmyk}{0.36,0,1,0}
\definecolor{tudelft-yellow}{cmyk}{0.02,0,0.54,0}

%% Use TU Delft cyan as the color for titles, unless the 'print' option is
%% specified, in which case we use anthracite, a dark gray, which is also used
%% for the thumb indices.
\definecolor{anthracite}{cmyk}{0,0,0,1}
\if@print
    \colorlet{title}{tudelft-cyan}
    %\colorlet{title}{anthracite}
\else
    \colorlet{title}{tudelft-cyan}
\fi
\colorlet{thumb}{anthracite}

%% Set the paper size to 17 by 24 cm, approximately halfway between A4 and A5.
\if@print
    \geometry{
        papersize = {173mm,246mm},
        layoutsize = {167mm,240mm},
        layoutoffset = {3mm,11mm},
        bindingoffset = 3mm
    }
\else
\geometry{papersize = {170mm,240mm},
        layoutoffset = {0mm,7mm}}
\fi
%% We decrease the margins slightly from the default (scale = 0.7).
\geometry{hscale=0.75,vscale=0.8}

\geometry{textwidth=127.4818mm}
%% Room for the two-line running header (fancyhdr asks for at least 17pt).
\geometry{headheight=17pt}

%% Redefine the title command to accept an optional subtitle.
\renewcommand*\title[2][]{%
    \def\@subtitle{#1}%
    \def\@title{#2}%
    %% Add the title to the PDF meta data.
    \hypersetup{pdftitle=#2}%
}
%% Redefine the author command to accept a first and last name, and to add the
%% full name to the PDF meta data.
\renewcommand*\author[2]{%
    \def\@firstname{#1}%
    \def\@lastname{#2}%
    \hypersetup{pdfauthor=#1\ #2}%
}

%% Remove the header and page number on empty pages.
\def\cleardoublepage{%
    \clearpage%
    \if@twoside%
        \ifodd\c@page%
        \else%
            \thispagestyle{empty}%
            \vspace*{\fill}%
            \newpage%
        \fi%
    \fi%
}

\if@print%
    \newcommand*\cropmarks{%
        \ifodd\c@page%
            \begin{tikzpicture}[remember picture,overlay]
                \draw ($(current page.north east)+(0mm,-3mm)$) -- ($(current page.north east)+(-2mm,-3mm)$);
                \draw ($(current page.north east)+(-3mm,0mm)$) -- ($(current page.north east)+(-3mm,-2mm)$);
                \draw ($(current page.south east)+(0mm,3mm)$) -- ($(current page.south east)+(-2mm,3mm)$);
                \draw ($(current page.south east)+(-3mm,0mm)$) -- ($(current page.south east)+(-3mm,2mm)$);
            \end{tikzpicture}%
        \else%
            \begin{tikzpicture}[remember picture,overlay]
                \draw ($(current page.north west)+(0mm,-3mm)$) -- ($(current page.north west)+(2mm,-3mm)$);
                \draw ($(current page.north west)+(3mm,0mm)$) -- ($(current page.north west)+(3mm,-2mm)$);
                \draw ($(current page.south west)+(0mm,3mm)$) -- ($(current page.south west)+(2mm,3mm)$);
                \draw ($(current page.south west)+(3mm,0mm)$) -- ($(current page.south west)+(3mm,2mm)$);
            \end{tikzpicture}%
        \fi%
    }
\else
    \newcommand*\cropmarks{}
\fi%

%%% Thumb indices consist of white text on a rectangular colored background. The
%%% font-size is 75% of the size of thumb height.
\newif\ifthumb
\newlength\thumbheight
\setlength\thumbheight{24pt}
\newlength\thumbedge
\setlength\thumbedge{4pt}
\newlength\thumbhspace
\setlength\thumbhspace{36pt}
\newlength\thumbvspace
\setlength\thumbvspace{2\thumbheight}

\newlength\thumbwidth
\setlength\thumbwidth{36pt}
\newlength\thumbspacing
\setlength\thumbspacing{2\thumbheight}

%% We need the TikZ library calc to calculate the coordinates of the thumb
%% indices.
\usetikzlibrary{calc}

%% The lthumb command prints the current chapter number in a thumb index on the
%% left (even) page.
\newcommand*\lthumb{%
    \ifthumb%
        \begin{tikzpicture}[remember picture,overlay]
            \coordinate (top margin) at (0pt,1in+\topmargin+\headheight+\headsep);
            \coordinate (left margin) at (1.1in+\evensidemargin,0pt);
            %% Calculate the corners of the thumb index based on the current
            %% chapter number.
            \coordinate (top left) at ($(current page.north west)-(top margin)-(0pt,\value{chapter}\thumbvspace-\thumbvspace)$);
            \coordinate (bottom right) at ($(top left)+(left margin)-(\thumbhspace,\thumbheight)$);
            %% Shift the left edge to prevent the rounded corner from showing.
            \coordinate (top left) at ($(top left)-(\thumbedge,0pt)$);
            %% Draw the thumb index.
            \fill[fill=thumb,rounded corners=\thumbedge](top left) rectangle (bottom right);
            %% Print the chapter number at the center right in the thumb index.
            \coordinate (center right) at ($(bottom right)+(0pt,0.5\thumbheight)$);
            \node at (center right)[anchor=east,inner sep=2\thumbedge]{
                \titlefont\bfseries\color{tudelft-white}
                \fontsize{0.75\thumbheight}{0.75\thumbheight}\selectfont
                \thechapter
            };
        \end{tikzpicture}%
    \fi%
}

%% rthumb draws a thumb index on the right (odd) page.
\newcommand*\rthumb{%
    \ifthumb%
        \begin{tikzpicture}[remember picture,overlay]
            \coordinate (top margin) at (0pt,1in+\topmargin+\headheight+\headsep);
            \coordinate (right margin) at (1.1in+\evensidemargin,0pt);
            %% Calculate the corners of the thumb index based on the current
            %% chapter number.
            \coordinate (top right) at ($(current page.north east)-(top margin)-(0pt,\value{chapter}\thumbvspace-\thumbvspace)$);
            \coordinate (bottom left) at ($(top right)-(right margin)-(-\thumbhspace,\thumbheight)$);
            %% Shift the left right to prevent the rounded corner from showing.
            \coordinate (top right) at ($(top right)+(\thumbedge,0pt)$);
            %% Draw the thumb index.
            \fill[fill=thumb,rounded corners=\thumbedge](top right) rectangle (bottom left);
            %% Print the chapter number at the center right in the thumb index.
            \coordinate (center left) at ($(bottom left)+(0pt,0.5\thumbheight)$);
            \node at (center left)[anchor=west,inner sep=2\thumbedge]{
                \titlefont\bfseries\color{tudelft-white}
                \fontsize{0.75\thumbheight}{0.75\thumbheight}\selectfont
                \thechapter
            };
        \end{tikzpicture}%
    \fi%
}

%% Page style for empty pages.
\fancypagestyle{empty}{%
    \fancyhf{}
    \renewcommand*\headrulewidth{0pt}
    \renewcommand*\footrulewidth{0pt}
    \fancyhead{\cropmarks}
}

%% Page style for title pages.
\fancypagestyle{plain}{%
    \fancyhf{}
    %\renewcommand*\headrulewidth{0pt}
    \renewcommand*\footrulewidth{0pt}
    \fancyhead{\cropmarks}
    %\fancyfoot[C]{\titlefont\thepage}
    \fancyhead[LE]{\cropmarks\lthumb\titlefont\color{thumb}\thepage}
    \fancyhead[RO]{\cropmarks\rthumb\titlefont\color{thumb}\thepage}
}

%% Fancy style for the main matter.
\fancypagestyle{mainmatter}{%
    \fancyhf{}
    %% Page numbers on the top left and top right.
    \fancyhead[LE]{\cropmarks\lthumb\fontsize{8.5pt}{8.5pt}\titlefont\color{thumb}\thepage}
    \fancyhead[RO]{\cropmarks\rthumb\fontsize{8.5pt}{8.5pt}\titlefont\color{thumb}\thepage}
    %% Chapter name on the left (even) page.
    \fancyhead[RE]{\fontsize{8.5pt}{8.5pt}\titlefont\titleshape\color{thumb}\nouppercase{\leftmark}}
    %% Section name on the right (odd) page.
    \fancyhead[LO]{\fontsize{8.5pt}{8.5pt}\titlefont\titleshape\color{thumb}\nouppercase{\rightmark}}
}

%% The mainmatter style is default for normal pages.
\pagestyle{mainmatter}

%% Print the current chapter and section at the top of the page in cyan.
\renewcommand*\chaptermark[1]{\markboth{\color{thumb}\thechapter\ #1}{}}
\renewcommand*\sectionmark[1]{\markright{\color{thumb}\thesection\ #1}}

%% The setheader command can be used to print the title of unnumbered chapters
%% in the page header.
\newcommand*\setheader[1]{\markboth{\color{thumb}#1}{\color{thumb}#1}}

%% Change the headrule command (from fancyhdr.sty) to draw the line below the
%% header in the title color.
\renewcommand*\headrule{%
    \if@fancyplain%
        \let\headrulewidth\plainheadrulewidth%
    \fi%
    {\color{thumb}\hrule\@height\headrulewidth\@width\headwidth}%
    \vskip-\headrulewidth%
}

%% Draw the line above a footnote in the title color as well.
\renewcommand*\footnoterule{%
    \vspace*{-3pt}%
    {\color{thumb}\hrule width 0.5\textwidth height 0.4pt}%
    \vspace*{2.6pt}%
}

%% A part title starts with a huge (96pt) bold black number, flushed to the
%% right, followed by the part name on the next line in the title color.
\titleformat{\part}[display]
    {\flushright\titlestyle}
    {\fontsize{96pt}{96pt}\selectfont\bfseries\thepart}
    {0pt}
    {\Huge\color{title}}
%% Separate the title from the text by two empty lines.
\titlespacing{\part}{0pt}{0pt}{2\baselineskip}
%% In the table of contents, the part name is preceded by an empty line, printed
%% in bold, and not followed by a line of dots.
\dottedcontents{part}[0em]{\vspace{\baselineskip}\titlefont\bfseries}{1.5em}{0pc}

%% Chapter titles have the same layout as parts.
\titleformat{\chapter}[display]
    {\flushright\titlestyle}
    {\fontsize{84pt}{84pt}\selectfont\bfseries\thechapter}
    {0pt}
    {\Huge\color{title}}
\titlespacing{\chapter}{0pt}{0pt}{2\baselineskip}
%% In the table of contents, a chapter is similar to a part, except that it is
%% preceded by half an empty line.
\dottedcontents{chapter}[1.5em]{\vspace{0.5\baselineskip}\titlefont\bfseries}{1.5em}{0pc}

%% Section titles start with the number in bold, followed by the name printed
%% in the title color.
\titleformat{\section}
    {\Large\bfseries\headerstyle}
    {\thesection\ }
    {0pt}
    {\color{black}}
%% Sections are preceded by an empty line.
\titlespacing{\section}{0pt}{\baselineskip}{0pt}
%% In the table of contents, section names are followed by a line of dots 8pt
%% apart.
\dottedcontents{section}[3.8em]{\titlefont}{2.3em}{8pt}

%% Subsection titles have the same layout as section titles, except in a smaller
%% font.
\titleformat{\subsection}
    {\large\bfseries\headerstyle}
    {\thesubsection\ }
    {0pt}
    {\color{black}}
\titlespacing{\subsection}{0pt}{\baselineskip}{0pt}
\dottedcontents{subsection}[7em]{\titlefont}{3.2em}{8pt}

%% Subsubsections have the same font and color as sections and subsections, but
%% are not preceded by a number.
\titleformat{\subsubsection}
    {\bfseries\headerstyle}
    {}
    {0pt}
    {\color{black}}
%% Subsubsections are preceded by an empty line and do not appear in the table
%% of contents.
\titlespacing{\subsubsection}{0pt}{\bigskipamount}{0pt}

%% Color the bullets of the itemize environment and make the symbol of the third
%% level a diamond instead of an asterisk.
\renewcommand*\labelitemi{\color{black}\textbullet}
\renewcommand*\labelitemii{\color{black}--}
\renewcommand*\labelitemiii{\color{black}$\diamond$}
\renewcommand*\labelitemiv{\color{black}\textperiodcentered}

%% The dedication is vertically centered on a separate page and flushed to the
%% right.
\newcommand\dedication[1]{%
    \thispagestyle{empty}%
    \vspace*{\fill}%
    \begin{flushright}%
        #1%
    \end{flushright}%
    \vspace*{\fill}%
    \cleardoublepage%
}

%% Define an unnumbered footnote command.
\def\blfootnote{\xdef\@thefnmark{}\@footnotetext}

%% The authors environment is used to display the authors of a chapter on the
%% title page. This is only necessary if multiple people contributed
%% significantly to the chapter.
\newcommand*\authors[1]{%
    \begin{center}%
        {\Large\bfseries #1}%
    \end{center}%
    \vspace{2\baselineskip}%
}

%% The epigraph environment can be used to to add a quote to the title page of
%% a chapter.
\newcommand\epigraph[3][2\baselineskip]{%
    \begin{flushright}%
        {\rmfamily\itshape #2}%
        \vskip 0.5\baselineskip%
        #3%
    \end{flushright}%
    \vspace{#1}%
}

%% The abstract environment is used for the abstract of a chapter.
\newenvironment{abstract}{%
    \list{}{\leftmargin\rightmargin}%
    \item%
    \relax%
    \rmfamily\itshape%
}{%
    \endlist%
}

%% Define a drop command which can be used to generate drop caps at the
%% beginning of a section.
\renewcommand*\LettrineTextFont{\titleshape}
\newcommand*\dropcap[2]{
    \lettrine[lines=2,findent=0.2em,nindent=0pt]{\color{black} #1}{#2}%
}

%% Create an unnumbered reference section.
\addto\captionsenglish{\renewcommand*\bibname{\color{black}References}}
\newcommand*\references[1]{%
    \printbibliography[heading=none]%
}

%% Hyperlinks are coloured in the digital version and hidden in print mode.
\if@print
    \hypersetup{hidelinks}
\else
    \hypersetup{
        colorlinks = true,
        linkcolor  = tudelft-cyan!70!black, % \ref, ToC, figures/tables
        citecolor  = tudelft-cyan!70!black, % \cite
        urlcolor   = tudelft-cyan!70!black  % \url, \href
    }
\fi
%% PDF metadata: document language, and show the title (not the file name) in
%% the PDF viewer's window title.
\hypersetup{pdflang=en-US, pdfdisplaydoctitle=true}

