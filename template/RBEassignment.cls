% Template for RBE assignments
% Daniel Montrallo Flickinger, PhD
% 2021

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{RBEassignment}[WPI RBE assignment class]





% Default Parameters
% ------------------

\RequirePackage{xkeyval}

\def\RBEtitle{Untitled Assignment}
\def\RBEcourse{RBE-000 Unknown Course}
\def\RBEsemester{Fall 0000}
\def\RBEauthor{Unknown Author}
\def\RBEnumber{0}
\def\RBEdue{NO DUE DATE}




% Based on the article class
\LoadClass[letterpaper]{article}


% Bring in a bunch of packages
% (yes they are all needed)
% ----------------------------



\RequirePackage[utf8]{inputenc}

\RequirePackage{palatino}
\RequirePackage[T1]{fontenc}


\RequirePackage{fontspec}
\setsansfont{Jura} % NOTE: Jura is a stand-in for Eurostile
\RequirePackage{fontawesome}


% \RequirePackage[ocr-a]{ocr}


\RequirePackage[explicit]{titlesec}


\RequirePackage{tikz}
\usetikzlibrary{shadows,calc,positioning,arrows,decorations.markings,automata,shapes.geometric}

\RequirePackage{pgfplots}
\pgfplotsset{compat=newest}
\RequirePackage{pgf-pie}

\RequirePackage{xifthen}

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



\RequirePackage{wrapfig}
\RequirePackage{mathabx}


\RequirePackage{natbib}
\RequirePackage{bibentry}
\nobibliography{%
bib/RBE_resources.bib}

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


% Define a nice header and footer
% -------------------------------


\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\pagestyle{fancy}

\lhead{Assignment \RBEnumber}
\rhead{\RBEtitle}

\renewcommand{\headrulewidth}{0pt}
\fancyfoot{}
\fancyfoot[L,R]{\thepage\ / \pageref{LastPage}}
\fancyfoot[L]{\RBEsemester ~ \RBEcourse ~ \textcolor{WPIcrimson}{WPI}}



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


\newcommand{\gradingrubric}[3]{%
\gradingWriteupSection{#1}
\gradingSubmissionSection{#2}{#3}
}


% Grading data:
% [1] points (0..1)
% [2] grade type
% [3] grade title
% [4] grade (long) description
\newcommand{\gradingdescdata}[4]{%
\gradeWriteupSections{%
\subsection{#2 \progressbar[filledcolor=WPIcrimson]{#1} \percentage{#1} #3}

#4
}
\gradeTableRows{%
\progressbar[filledcolor=WPIcrimson]{#1} \percentage{#1} & 
#2 &
#3 \\ \hline}
\gradePieFields{#1/#3, }
}


\makeatletter
\newcommand{\gradeTableRows}[1]{\g@addto@macro\@gradeTableRows{#1}}
\newcommand{\@gradeTableRows}{%
    \hline
    \rowcolor{black}
    \textcolor{white}{\textbf{Weight}} &
    \textcolor{white}{\textbf{Type}} &
    \textcolor{white}{\textbf{Component} (See Table~\ref{tab:submissionLegend})}\\ \hline
}

\newcommand{\gradeWriteupSections}[1]{\g@addto@macro\@gradeWriteupSections{#1}}
\newcommand{\@gradeWriteupSections}{}

\newcommand{\gradePieFields}[1]{\g@addto@macro\@gradePieFields{#1}}
\newcommand{\@gradePieFields}{}

\makeatother



\newcommand{\gradingSubmissionSection}[2]{%

\section{Submission}
\label{sec:submission}

% TODO: make a big box with diagonal stripes saying 'late submissions are not accepted'

This assignment is due \RBEdue.  
\textcolor{red}{\em Late submissions are not accepted.}  Upload completed assignment components (as individual files, \textbf{not} a single ZIP or TAR file) to the course site on \href{https://canvas.wpi.edu}{Canvas}.

Submit work early, as partial credit for incomplete work is preferred to earning a zero for missing work.  Submissions may be ammended up until the deadline.  


\section{Grading Rubric}
\label{sec:rubric}

Refer to Table~\ref{tab:gradingRubric} for the grading rubric.  
% FIXME: get pie charts working in grade rubric
% \begin{tikzpicture}
% \pie[sum=1, hide number, text=legend]{#2 0/}
% \end{tikzpicture}

\begin{table}[hb]
  \caption{Grading rubric\label{tab:gradingRubric}}
   \begin{tabularx}{\linewidth}{|r|l|X|}
        #1
    \end{tabularx}
\end{table}


}



\newcommand{\gradingWriteupSection}[1]{%

\section{Results}
\label{sec:results}

Complete the components discussed in the following sections to receive full credit on this assignment.  Refer to Section~\ref{sec:submission} for submission guidelines, and Section~\ref{sec:rubric} for a summary of the grading rubric.  Consider submitting your work as you complete each component, as partial credit is preferred to no credit.  


#1

}




% Build tetromino obstacle fields
% -------------------------------


\newcommand{\ifequals}[3]{\ifthenelse{\equal{#1}{#2}}{#3}{}}
\newcommand{\case}[2]{#1 #2}
\newenvironment{switch}[1]{\renewcommand{\case}{\ifequals{#1}}}{}

\newcommand{\tetI}[2] {% I tetromino
\fill (#1,#2) rectangle ++ (1,4);
}

\newcommand{\tetL}[2] {% L tetromino
\fill (#1+1,#2) rectangle ++ (1,3);
\fill (#1,#2+2) rectangle ++ (1,1);
}

\newcommand{\tetS}[2] {% S tetromino
\fill (#1+1,#2) rectangle ++ (1,2);
\fill (#1,#2+1) rectangle ++ (1,2);
}

\newcommand{\tetT}[2] {% T tetromino
\fill (#1+1,#2) rectangle ++ (1,3);
\fill (#1,#2+1) rectangle ++ (1,1);
}

\newcommand{\tetZ}[2] {% Z tetromino
\fill (#1,#2) rectangle ++ (1,2);
\fill (#1+1,#2+1) rectangle ++ (1,2);
}

\newcommand{\tetO}[2]{% O tetromino
\fill (#1,#2) rectangle ++ (2,2);
}

\newcommand{\placeTet}[3] {
\begin{switch}{#1}
    \case{0}{\tetI{#2}{#3}}
    \case{1}{\tetL{#2}{#3}}
    \case{2}{\tetS{#2}{#3}}
    \case{3}{\tetT{#2}{#3}}
    \case{4}{\tetZ{#2}{#3}}
    \case{5}{\tetO{#2}{#3}}
\end{switch}
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

\makeatletter
\renewcommand\Huge{\@setfontsize\Huge{50pt}{18}}
\makeatother


\newcommand{\RBEassignmentheader}{%




% Draw a big colored filled polygon
\backgroundsetup{
scale=1, angle=0, opacity=1,
contents={%
\begin{tikzpicture}[remember picture,overlay]
  %
  \path [fill=WPIcrimson] (-4.25in,-5.5in) -- (0in,-5.5in) -- (-4.25in,4.0in) -- cycle;
  %
  \path [fill=WPIgray] (-4.25in,5.5in) -- (2.0in,5.5in) -- (-4.25in,-1.0in) --cycle;
  %
\end{tikzpicture}%
} % contents
} % backgroundsetup






% Begin title page
\begin{titlepage}
\BgThispage
\newgeometry{top=1cm,left=1cm,right=1cm,bottom=2cm}
\noindent
\begin{flushright}
\textcolor{WPIgray}{\sffamily\Huge\textbf{\RBEnumber}}
\end{flushright}
\includegraphics[width=3in]{fig/WPI_Inst_Prim_FulClr.png}%
\noindent
\begin{flushright}
\textcolor{black}{\sffamily\Large\RBEcourse\\\RBEauthor}\\
\vspace{0.25in}
\textcolor{WPIcrimson}{\sffamily\Huge\textbf{\RBEtitle}}
\end{flushright}
\vspace{4.5in}\par\noindent
\textcolor{white}{\sffamily\Large DUE: \RBEdue}
\end{titlepage}


\restoregeometry


} % end of \newcommand{RBEassignmentheader}


\newcommand{\assignmentfooter}{%

\begin{table}
\caption{Submission legend%
\label{tab:submissionLegend}}
  \begin{tabularx}{\linewidth}{|l|X|}
      \hline
      \faFileText & report or brief writeup \\ \hline
      \faFileCodeO & source code (or link to revision control) \\ \hline
      \faFileVideoO & video presentation, or simulation animation \\ \hline
      \faLineChart & data plot or image \\ \hline
      \faComment & post in the discussion forum on \href{https://canvas.wpi.edu}{Canvas} \\ \hline
    \end{tabularx}
\end{table}


\vspace{6em}
\begin{center}
{\small \sffamily Last update: \today}
\end{center}

}
