% ---------------------------------------------------------------------------
% Fichero   : acreditacion.cls 
% Contenido : Clase para el documento de acreditación de méritos 
% Autor     : Antonio Ruiz Cortés 
% ---------------------------------------------------------------------------


% This material is subject to the LaTeX Project Public License.
% See  http://www.ctan.org/tex-archive/help/Catalogue/licenses.lppl.html
% for the details of that license

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{acreditacion}[19/11/2012 Documentacion de acreditacion de meritos]

% Set font
\DeclareOption{helvetica}{%                       
  \renewcommand{\rmdefault}{phv}
  \renewcommand{\sfdefault}{phv}
}
\DeclareOption{arial}{%                       
  \renewcommand{\rmdefault}{ma1} % (this font is NOT installed by default!)
  \renewcommand{\sfdefault}{ma1}
}
\DeclareOption{narrow}{
  \renewcommand{\seriesdefault}{mc} % Narrow
  \renewcommand{\bfdefault}{bc}  % Boldface narrow
}
% No title
\DeclareOption{notitle}{\renewcommand*\ecvtitle{}}

% Pass all other options (a4paper, 10pt, draft, openbib, etc...) to article
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
} 

\ProcessOptions\relax

\LoadClass[a4paper]{article}
\RequirePackage{fancyhdr} % For page numbering

% Footnote or footer to be shown on every page
\newcommand\ecvfootnote[1]{%
  \rfoot{\begin{minipage}{60mm}
     \footnotesize #1%
  \end{minipage}}}

% --------
% Márgenes
% --------

% Estas son las medidas de los márgenes del fichero Word oficial (Amador)

%\usepackage[a4paper,left=2.5cm,right=2.5cm,top=2cm,bottom=2.25cm]{geometry}

% Modificaciones:
% newpage. Para que cada sección comience en una nueva página
% Modificación eliminada (Amador)

%Los siguiente comenado se han comentado pq están con otros valores en preamble.tex
%\renewcommand\section{\@startsection {section}{1}{\z@}%
%                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
%                                   {0.3ex \@plus.1ex}%
%                                   %{\newpage\normalfont\normalsize\bfseries}}
%                                   {\normalfont\normalsize\bfseries}}
%                                   
%\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
%                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
%                                     {1.5ex \@plus .2ex}%
%                                     {\normalfont\normalsize\bfseries}}
%
%\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
%                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
%                                     {1.5ex \@plus .2ex}%
%                                     {\normalfont\normalsize\bfseries}}
%
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\normalsize\bfseries}}

\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\normalfont\normalsize\bfseries}}

% -------------------------
% Cambio 16/1/2006 (Amador)
% -------------------------

\renewenvironment{thebibliography}[1]
     {\subsection{\refname}%
      \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
                                   
\newcommand{\url}[1]{{\texttt{\small{#1}}}}
\newcommand{\foreign}[1]{\emph{#1}}



%%%%%%%%%%%%%%%%%%%%%%
% Comentarios enmarcados

\setlength{\fboxsep}{0.15cm}
\newlength {\longComentario}
\setlength{\longComentario}{0.9\textwidth}
\newcommand{\comentario}[1]
{\goodbreak \smallskip \fbox{\begin{footnotesize} {\begin{minipage} {\longComentario} #1
\end{minipage} }\end{footnotesize}} \smallskip}

\newcommand{\provisional}[1]
{\textcolor{blue} {\goodbreak \smallskip \noindent \fbox{ {\begin{minipage} {\textwidth} #1
\end{minipage} } } \smallskip} }

%\newcommand{\provisional}[1] {\comentario{\textcolor{blue} #1}}

\newcommand{\tarea}[2]{{\textcolor{red}{\comentario{\textcolor{blue}{#1}: #2}}}}

\newcommand{\aviso}[1]{{\textcolor{red}{[#1]}}}