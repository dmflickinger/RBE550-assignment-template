% Template for RBE assignments
% Daniel Montrallo Flickinger, PhD
% 2021

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{RBEassignment}[WPI RBE assignment class]



% Based on the article class
\LoadClass[letterpaper]{article}



% Parameters
% ----------



\RequirePackage{pgfkeys}

\pgfkeys{
/myRBEassignmentheader/.is family, /myRBEassignmentheader,
default/.style =
  {title = Unknown Title, author = Unknown Author, course = Unknown Course, number = Unknown, due = Unknown},
title/.estore in = \myRBEassignmentheaderTitle,
author/.estore in = \myRBEassignmentheaderAuthor,
course/.estore in = \myRBEassignmentheaderCourse,
number/.estore in = \myRBEassignmentheaderNumber,
due/.estore in = \myRBEassignmentheaderDue,
% abstract/.estore in \myRBEassignmentheaderAbstract,
}





% Bring in a bunch of packages
% (yes they are all needed)
% ----------------------------


\RequirePackage{lipsum}

\RequirePackage[utf8]{inputenc}

\RequirePackage{palatino}
\RequirePackage[T1]{fontenc}


\RequirePackage{fontspec}
\setsansfont{Jura}
% NOTE: Jura is a stand-in for Eurostile

% \RequirePackage[ocr-a]{ocr}


\RequirePackage[explicit]{titlesec}


\RequirePackage{tikz}
\usetikzlibrary{shadows,calc,positioning,arrows,decorations.markings,automata,shapes.geometric}


\RequirePackage{dot2texi}
\RequirePackage{booktabs}
\RequirePackage{colortbl}
\RequirePackage{tabularx}

\RequirePackage{xfp,xparse}

\ExplSyntaxOn
\int_new:N\l_bjprim_round_int
\keys_define:nn {bjprim}
{
   positions-after-comma .int_set:N = \l_bjprim_round_it
}

\NewDocumentCommand\percentage { O{} m }
{
   \keys_set:nn {bjprim}{positions-after-comma=0,#1}
   \fpeval{round(#2*100,\l_bjprim_round_int)}\%
}
\ExplSyntaxOff



\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\pagestyle{fancy}


\RequirePackage[some]{background}

\RequirePackage{geometry}
\RequirePackage{xcolor}

% Define colors
% -------------

\definecolor{WPIgray}{RGB}{169,176,183}
\definecolor{WPIcrimson}{RGB}{172,43,55}



\RequirePackage{hyperref}
\hypersetup{%
colorlinks=false,
linkbordercolor=red,
pdfborderstyle={/S/U/W 1}
}
\RequirePackage{pdfescape}
\RequirePackage{xstring}



\RequirePackage{listings}

\RequirePackage{natbib}
\RequirePackage{bibentry}
\nobibliography{%
/bib/RBE_resources.bib}

\RequirePackage{progressbar}


% Create an index file for all URLs in the document
% -------------------------------------------------


% \RequirePackage{filecontents}
\begin{filecontents*}{\jobname-url.mst}
% Input style specifiers
keyword "\\urlentry"
% Output style specifiers
preamble "\\begin{theurls}"
postamble "\n\\end{theurls}\n"
group_skip ""
headings_flag 0  
item_0 "\n\\urlitem{"
delim_0 "}{"
delim_t "}"
line_max 500
\end{filecontents*}


% Define a nice footer
% --------------------

\renewcommand{\headrulewidth}{0pt}
\fancyfoot{}
\fancyfoot[L,R]{\thepage\ / \pageref{LastPage}}
\fancyfoot[L]{Summer 2021 ~ RBE-550 Motion Planning ~ \textcolor{WPIcrimson}{WPI}}



% Format shell commands amd component names nicely
% ------------------------------------------------

\newcommand*{\pkgComponent}[1]{\texttt{#1}}%


\lstdefinestyle{BashInputStyle}{
  language=bash,
  basicstyle=\small\sffamily,
  numbers=left,
  numberstyle=\tiny,
  numbersep=3pt,
  frame=tb,
  columns=fullflexible,
  backgroundcolor=\color{blue!20},
  linewidth=0.9\linewidth,
  xleftmargin=0.1\linewidth
}



% Nice section title formatting
% -----------------------------



% fancy up the section titles
\definecolor{sectioncrimson}{RGB}{171,25,45}
\newcommand{\hsp}{\hspace{8pt}}


\titleformat
{\section}
[hang]
{\normalfont\sffamily\huge\bfseries}
{}
{0pt}
{
\begin{tikzpicture}
\node[draw,fill=white,text depth=1ex,font=\Large] (main){\hsp#1};
\node[draw,fill=black,text depth=1ex,font=\Large] at (main.west){\textcolor{white}\thesection};
\end{tikzpicture}
}

% fancy up the subsection titles
\titleformat
{\subsection}
[hang]
{\normalfont\sffamily\Large\bfseries}
{}
{0pt}
{
\begin{tikzpicture}
\node[rectangle, draw, outer sep=0pt, inner sep=4pt,font=\Large](main){\thesubsection \hsp #1};
\end{tikzpicture}
}





% Build a grading rubric chart
% ----------------------------

\newcommand{\gradingdata}[3]{%
  \gdef\gradepoints{#1}%
  \gdef\gradesubmit{#2}%
  \gdef\gradedescription{#3}%
  \createGradeRow
}

\newcommand{\createGradeRow}{%
  \wlog{\gradepoints \gradesubmit \gradedescription}
  \progressbar[filledcolor=WPIcrimson]{\gradepoints} \percentage{\gradepoints} & \gradesubmit & \gradedescription \\ \hline
}


\newcommand{\gradingtable}[1]{%

\section{Grading and Submission}

% FIXME: get the due date here
% This assignment is due on \assignmentdue, at 11:00 GMT.  
{\em Late submissions are not accepted.}  Upload completed assignment components to the course site on \href{https://canvas.wpi.edu}{Canvas}.


\begin{table}[hb]
   \begin{tabularx}{\linewidth}{|r|l|X|}
       \hline
       \rowcolor{black}
         \textcolor{white}{\textbf{Weight}} &
         \textcolor{white}{\textbf{Type}} &
         \textcolor{white}{\textbf{Component}} \\ \hline
       #1
      \end{tabularx}
   \end{table}   
}




% Build a list of URLs in the document
% ------------------------------------

% REF: https://tex.stackexchange.com/questions/121977/auto-generate-list-of-url-usages-within-document

\makeatletter
\newwrite\file@url
\openout\file@url=\jobname-url.idx\relax

\newcommand*{\write@url}[1]{%
  \begingroup
    \EdefEscapeHex\@tmp{#1}%
    \protected@write\file@url{}{%
      \protect\urlentry{\@tmp}{\thepage}%
    }%
  \endgroup
}
\let\saved@hyper@linkurl\hyper@linkurl
\renewcommand*{\hyper@linkurl}[2]{%
  \write@url{#2}%
  \saved@hyper@linkurl{#1}{#2}%
}
\newcommand*{\listurlname}{List of URLs}
\newcommand*{\printurls}{%
  \InputIfFileExists{\jobname-url.ind}{}{}%
}
\newenvironment{theurls}{%
  \section*{\listurlname}%
  \@mkboth{\listurlname}{\listurlname}%
  \let\write@url\@gobble  
  \ttfamily
  \raggedright
  \setlength{\parfillskip}{0pt}%
}{%
  \par
}
\newcommand*{\urlitem}[2]{%
  \hangindent=1em
  \hangafter=1   
  \begingroup    
    \EdefUnescapeHex\@tmp{#1}%
    \expandafter\url\expandafter{\@tmp}%
  \endgroup
  \urlindex@pfill
  \IfSubStr{#2}{,}{pp}{%
    \IfSubStr{#2}{-}{pp}{p}%
  }.\@\space\ignorespaces
  #2%
  \par
}
\newcommand*{\urlindex@pfill}{% from \pfill of package `doc'
  \unskip~\urlindex@dotfill
  \penalty500\strut\nobreak
  \urlindex@dotfil~\ignorespaces
}
\newcommand*{\urlindex@dotfill}{% from \dotfill of package `doc'
  \leaders\hbox to.6em{\hss .\hss}\hskip\z@ plus  1fill\relax
}
\newcommand*{\urlindex@dotfil}{% from \dotfil of package `doc'
  \leaders\hbox to.6em{\hss .\hss}\hfil
}
\makeatother






% Title Page
% ----------

\newcommand{\RBEassignmentheader}[1][]{%

\pgfkeys{/myRBEassignmentheader, default, #1}


% \author{%
% \sffamily\textbf{\myRBEassignmentheaderAuthor}%
% }

% Draw a big colored filled polygon
\backgroundsetup{
scale=1, angle=0, opacity=1,
contents={\begin{tikzpicture}[remember picture,overlay]
           \path [fill=WPIcrimson] (current page.south west) -- (current page.south east) --++(-13cm,30cm) --++(-16.7cm,0) -- (current page.south west) -- cycle;
           \draw [color=white, line width = 1mm] (5,0) --(5,0.5\paperheight);
\end{tikzpicture}}
}


\pagecolor{WPIgray}


% Begin title page
\begin{titlepage}
\BgThispage
\newgeometry{left=1cm,right=6cm,bottom=2cm}
\noindent
\vspace*{0.10\textheight}
\includegraphics[width=7cm]{fig/WPI_Inst_Prim_FulClr.png}%
\noindent
\begin{flushright}
\textcolor{white}{\sffamily \myRBEassignmentheaderCourse \\%
\small{\myRBEassignmentheaderAuthor} \\%
{\Huge\textbf Assignment~\myRBEassignmentheaderNumber\\\myRBEassignmentheaderTitle}}
\vspace*{5cm}\par
\noindent
\begin{minipage}{0.5\linewidth}
\vspace{5pt}
\textcolor{white}{\sffamily\Large DUE: \myRBEassignmentheaderDue}
\end{minipage}
\end{flushright}

\end{titlepage}


\restoregeometry
\pagecolor{white}

}


