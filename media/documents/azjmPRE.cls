
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{azjmPRE}   
\LoadClass[a4paper, 11pt, twoside]{article}% JAH 20090725, changed to match published guidelines 
%changed by baris 21-10-2009 12 pt to 11pt reason: we can update web according to these. and we have used 11pt.

%commented by baris 21-10-2009 reason. updated use of require package
%\RequirePackage[dvips]{graphicx}
%\RequirePackage{amsfonts,amssymb,amsbsy,amsmath,amsthm}
%\RequirePackage{ifthen}
%\RequirePackage{cite}

\usepackage[dvips]{graphicx} % JAH 20091021 graphicx commented below, since this is here
\usepackage{amsfonts,amssymb,amsbsy,amsmath,amsthm}
\usepackage{ifthen}
%\usepackage{cite} % JAH comment out because should not be used with natbib 20091022

%commented by baris 21-10-2009, reason:may cause problem 
%\usepackage{charter}           
%\usepackage[charter]{mathdesign}
%\usepackage{graphicx} %by baris 21-10-2009 moved from sample.tex 
\usepackage[numbers]{natbib}  %by baris 21-10-2009 moved from sample.tex %may cause without natbib -suggestion: comment out there.
\allowdisplaybreaks % %by baris 21-10-2009 moved from sample.tex

\newboolean{PG@odd}  
\newboolean{REV@art} 
\newboolean{DRAFT@copy} 
\newboolean{ONE@page} 
\newboolean{START@even} 
\setboolean{PG@odd}{true}
\setboolean{REV@art}{false}
\setboolean{DRAFT@copy}{false}
\setboolean{ONE@page}{false}
\setboolean{START@even}{false}
\DeclareOption{odd}{\setboolean{PG@odd}{true}}
\DeclareOption{even}{\setboolean{PG@odd}{false}}
\DeclareOption{review}{\setboolean{REV@art}{true}}
\DeclareOption{draft}{\setboolean{DRAFT@copy}{true}}
\DeclareOption{onepage}{\setboolean{ONE@page}{true}}
\DeclareOption{starteven}{\setboolean{START@even}{true}}

\ProcessOptions
% general setting
\headsep=5mm
\headheight=5mm
\topmargin=0pt
\oddsidemargin=0pt
\evensidemargin=0pt
\textheight=190truemm
\textwidth=135truemm

\setlength\footnotesep{3.5\p@}
\footskip=4truemm

\renewcommand{\baselinestretch}{1.0}
\renewcommand{\arraystretch}{1.0}
\abovedisplayskip=10pt plus 9pt minus 2.5pt%
\belowdisplayskip=10pt plus 9pt minus 2.5pt

\newlength{\titleright}
\setlength{\titleright}{1cm}

\AtBeginDocument{
  \immediate\write\@auxout{\string
  \newlabel{FirstPage}{{}{\thepage}}}
}

\AtEndDocument{
  \clearpage\addtocounter{page}{-1}
  \immediate\write\@auxout{\string
  \newlabel{LastPage}{{}{\thepage}}}
  \addtocounter{page}{1}
}

\newcommand\journalname{\textit{Azerbaijan Journal of Mathematics}}
\newcommand\journalshortname{\textit{AZJM}}
\newcommand\thisnumber{\textit{1}}
\newcommand\thisyear {\textit{2026}}
\newcommand\thismonth{\textit{January}}
\newcommand\thisvolume{\textit{16}}
\newcommand\journalissn{\textit{2218-6816}}
%\newcommand\journalwebpage{www.azjm.org}
\newcommand\journalabbreviation{\textit{AZJM}}
\newcommand\copyrightyear{\textit{2010}}
\newcommand\journalwebpagehttp{http://www.azjm.org}
\def\thispagestart{\pageref{FirstPage}}
\def\thispageend{\pageref{LastPage}}


\def\ps@firstpage{\ps@empty

\def\@oddfoot{\footnotesize \textrm {\journalwebpagehttp \hfil} \thepage \hfil 
                \copyright ~ \copyrightyear \  ~ \textrm {\journalabbreviation ~ All rights reserved.}} 
  \let\@evenfoot\@oddfoot
%  \def\@oddhead{\usebox{\lheadbox} \hfil \usebox{\rheadbox}

% BURALARI BARI� DE���T�RD� orjinal kod a�a��da


% Buraya Kadar bar��



 \def\@oddhead{
      \parbox{\textwidth}{\textrm {\textbf \textit{\journalname} }
 \\ \textrm {\textit{V.} \thisvolume, \textit{No} \thisnumber, \thisyear, \thismonth}
 \\ \textrm { \textit{ISSN} ~ \journalissn ~ }
  \\ \textrm { \textit{https://doi.org/10.59849/2218-6816.\thisyear.\thisnumber.\thepage}}
 
 
 % \\ \textrm { \copyright ~  \copyrightyear ~ \journalabbreviation}

%\\ \textbf{\begin{center}
%Honorary Invited Paper
%           \end{center}}
 
 }
 
}
\let\@evenhead\@oddhead % in case an article starts on a left-hand page
 \let\@mkboth\@empty
} 

\def\ps@headings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
%      \def\@oddhead{\footnotesize \thepage\hfil\leftmark}%
%      \def\@evenhead{\footnotesize \rightmark\hfil\thepage}%
\ifthenelse{\boolean{PG@odd}}
      { \def\@evenhead{\footnotesize \thepage\hfil\leftmark}   % The first page number is odd
        \def\@oddhead{\footnotesize \rightmark\hfil\thepage} } %
      { \def\@oddhead{\footnotesize \thepage\hfil\leftmark}    % The first page number is even
        \def\@evenhead{\footnotesize \rightmark\hfil\thepage} }%
      \let\@mkboth\markboth
}

\renewcommand\maketitle{\par
   \begingroup
   \global\@topnum\z@
   \@maketitle
   \thispagestyle{firstpage}
   \endgroup
   \global\let\thanks\relax
   \global\let\maketitle\relax
   \global\let\@maketitle\relax
   \global\let\@thanks\@empty
   \global\let\@author\@empty
   \global\let\@date\@empty
   \global\let\@title\@empty
   \global\let\title\relax
   \global\let\author\relax
   \global\let\date\relax
   \global\let\and\relax
}

%
\renewcommand\@maketitle{
  \normalfont\normalsize
  \global\topskip8\p@\relax % 5.5pc   "   "   "     "     "
  \vfil\null
%  \vskip 30\p@
  \@settitle
  \ifx\@empty\author 
     \else 
         \@setauthor 
         \markboth
          {\ifx\@empty\shortauthor {\footnotesize\@author}
\else {\footnotesize \noexpand\shortauthor} \fi
{\footnotesize / \journalshortname , \thispagestart-\thispageend} 
}
          {\ifx\@empty\shortauthor {\footnotesize\@author} \else {\footnotesize \noexpand\shortauthor} 
{\footnotesize /  \journalshortname,~\thispagestart-\thispageend} 
\fi}

  %       {\ifx\@empty\shorttitle {\footnotesize\@title} \else {\footnotesize \shorttitle} \fi}
%          {\ifx\@empty\shortauthor {\footnotesize\@author} \else {\footnotesize \shortauthor} \fi}
  \fi
  \ifx\@empty\@address \else \@setaddress \fi
\noindent\hrulefill
  \@setabstract 
  \vspace{-12pt}
  \ifx\@empty\@both\else \@setboth\fi
  \ifx\@empty\@keywords\else \@setkeywords\fi
  \ifx\@empty\@pac\else \@setpac\fi
  \ifx\@empty\@pacs\else \@setpacs\fi
  \ifx\@empty\@ams\else \@setams\fi
  \ifthenelse{\boolean{ONE@page}}
  {}
  {\noindent\hrulefill}
  \normalsize
}

% footnote for corr author


%\setlength{\skip\footins}{2.5pc}
\renewcommand{\footnoterule}{\noindent\rule{5pc}{0.25pt}\vspace*{6pt}}
\renewcommand{\thefootnote}{\fnsymbol{footnote}}
\long\def\@makefntext#1{\parindent 1em
\noindent{$\m@th^{\@thefnmark}$}#1}

%\def\corraddr#1{\footnotetext[1]{Correspondence to: #1}\stepcounter{footnote}}
\def\corraddr#1{} % do not need address anymore!

% JAH 20090782 set to left justify
\def\email#1{\def\@email{#1}}
\let\@email=\@empty
\def\@setemail{\flushleft{{\it Email address:} \@email}}

\def\emails#1{\def\@emails{#1}}
\let\@emails=\@empty
\def\@setemails{\flushleft{{\it Email addresses:} \@emails}}

% Tek yazarlı corresponding author tek. yazılmıyor. by baris
%        \def\corrauth{\footnotemark[1]\footnotetext[1]{
%         \ifx\@empty\@email\else \@setemail\fi
%         \ifx\@empty\@emails\else \@setemails\fi}\stepcounter{footnote}}


%\def\corrauth{\footnotemark[1]\footnotetext[1]{Corresponding author.
%\ifx\@empty\@email\else \@setemail\fi
% \ifx\@empty\@emails\else \@setemails\fi}\stepcounter{footnote}}

% JAH 20090725 Separated \corrauth from emails so don't have to have corrauth to print email addresses
\def\corrauth{\footnotemark[1]\footnotetext[1]{Corresponding author.}\stepcounter{footnote}}

\def\emft{\footnotetext[0]{\ifx\@empty\@email\else \@setemail\fi
 \ifx\@empty\@emails\else \@setemails\fi}}

\def\affilnum#1{${}^{#1}$}
\def\affil#1{${}^{#1}$}
\def\comma{$^{\textrm{,}}$}

%%%%%%%%%%%%%%%%%%%%%%%%%%

% define environment for title and author
\newenvironment{titquote}{\begin{list}{}
{\setlength{\leftmargin}{0pt}
 \setlength{\rightmargin}{\titleright}
 \setlength{\topsep}{6pt}
 \setlength{\parskip}{0pt}}
 \item[]}{\end{list}}
%
% Article titles
%
% Usage: \title[Short title]{Full title}
% [Short title] is optional; use where title is too long
% or contains footnotes, 50 characters maximum
%
\renewcommand*{\title}[2][]{\gdef\shorttitle{#1}\gdef\@title{#2}}
\let\shorttitle=\empty
\def\@settitle{
\begin{center}
 \baselineskip14\p@\relax
  \begin{titquote}
  \Large  \bfseries
  \ifthenelse{\boolean{REV@art}}
  {  \item[]
     {\LARGE R}{\large EVIEW }{\LARGE A}{\large RTICLE} } 
  {}
  \item[]
  \ \\	% JAH 20091022 inserted to push title down 1 line
  \@title
%  \end{center}%
  \end{titquote}
}
%
% List of authors
%
% Usage \author[Short form]{List of all authors}
% The short form excludes footnote symbols linking authors to addresses
% and is used for running heads in printed version (but not on preprints)
%
\let\shortauthor=\empty
\renewcommand*{\author}[2][?]{
     \gdef\shortauthor{?} 
     \gdef\@author{#2}
   \ifthenelse{\equal{#1}{?}}
     { \gdef\shortauthor{\let\comma=\empty \let\corrauth=\empty \renewcommand{\affil}[1]{} #2} }
     { \gdef\shortauthor{#1}}
}
\def\@setauthor{%\begin{center}%
  %\bfseries
  \begin{titquote}
  \large 
%  \item[]
  \@author\emft
  \end{titquote}
%  \end{center}%
}

%
% Affiliation (authors address)
%
% Usage: \address{Address of first author}
%        \address{Address of second author}
% Use once for each address, use symbols \dag \ddag \S \P $\|$
% to connect authors with addresses
%
\def\address#1{\def\@address{#1}}
\let\@address=\@empty
\def\@setaddress{\vspace{-12pt}
   \begin{titquote}
   %\rm\small \@address
   \rm\it\small \@address
   \end{titquote}
}
%
\def\keywords#1{\def\@keywords{#1}}
\let\@keywords=\@empty
\def\@setkeywords{
     \addtolength{\topsep}{-6pt}
     \begin{trivlist}
     %\item[]\rm\small {\sc\small Key Words and Phrases}: \@keywords
     \item[]\rm\small {\bf\small Key Words and Phrases}: \@keywords
     \end{trivlist}
}
%
%
% AMS or PACS
% Usage: \both{57.XX, 58.XX}
%
\def\both#1{\def\@both{#1}}
\let\@both=\@empty
\def\@setboth{
     \addtolength{\topsep}{-7pt}
     \begin{trivlist}
     \item[]\rm\small {\bf \small 2000 Mathematics Subject Classifications or PACS}: \@both
     \end{trivlist}
}
%
% American Mathematical Society Classification Numbers
% Usage: \ams{67.XX, 58.XX}
%
\def\ams#1{\def\@ams{#1}}
\let\@ams=\@empty
\def\@setams{
     \addtolength{\topsep}{-2pt}
     \begin{trivlist}
     \item[]\rm\small {\bf \small 2010 Mathematics Subject Classifications}: \@ams
     \end{trivlist}
}
%
% Physics & Astronomy Classification Numbers (more than one)
% Usage \pacs{31.10, 31.20T}
%
\def\pac#1{\def\@pac{#1}}
\let\@pac=\@empty
\def\@setpac{
     \addtolength{\topsep}{-6.5pt}
     \begin{trivlist}
     \item[]\rm\small {\bf\small PACS}: \@pac
     \end{trivlist}
}
%
% Physics & Astronomy Classification Numbers (2006) (more than one)
% Usage \pacs{31.10, 31.20T}
%
\def\pacs#1{\def\@pacs{#1}}
\let\@pacs=\@empty
\def\@setpacs{
     \addtolength{\topsep}{-6.5pt}
     \begin{trivlist}
     \item[]\rm\small {\bf\small PACS (2006)}: \@pacs
     \end{trivlist}
}
%
\newbox\abstractbox
%\renewenvironment{abstract}{%
%      \vspace{6pt plus3pt minus3pt}
%      \begin{quote}
%%      \item[]{\bfseries \abstractname.}\quad\rm\ignorespaces}
%      \rm\ignorespaces}
%      {\end{quote}\if@titlepage\newpage\else\vspace{0\p@ plus0\p@}\fi}
\renewenvironment{abstract}{%
  \ifx\maketitle\relax
    \ClassWarning{\@classname}{Abstract should precede
      \protect\maketitle\space in AMS documentclasses; reported}%
  \fi
  \global\setbox\abstractbox=\vtop \bgroup
    \normalfont\small
    \list{}{\labelwidth\z@
      % comment in v1.2
      % \leftmargin6pc %\rightmargin\leftmargin
      \leftmargin0pc %\rightmargin\leftmargin           % baris barış burada abstractın yerinideğiştirdi
       \itemindent\z@
      \parsep\z@ \@plus\p@
      \let\fullwidthdisplay\relax
    }%
    % v change Abstract from sc -> bf
    %\item[\hskip\labelsep\scshape\abstractname.]%
    \item[\hskip\labelsep\bfseries\abstractname.]%
}{%
  \endlist\egroup
  \ifx\@setabstract\relax \@setabstracta \fi
}
\def\@setabstract{\@setabstracta \global\let\@setabstract\relax}
\def\@setabstracta{%
  \ifvoid\abstractbox
  \else
    \skip@6\p@ \advance\skip@-\lastskip
    \advance\skip@-\baselineskip \vskip\skip@
    \box\abstractbox
    \prevdepth\z@ % because \abstractbox is a vtop
  \fi
}

\def\proofBox{\mbox{ }\rule[0pt]{1.5ex}{1.5ex}}
%========================= Floats, tables, figures =================
%\renewcommand{\floatpagefraction}{1}
%\floatsep=10pt plus 2.5pt minus 1pt
%\textfloatsep=10pt plus 2.5pt minus 1pt
%\intextsep=10pt plus 2.5pt minus 1pt
%%\doublerulesep=0pt
%
%\abovecaptionskip=3pt
%\belowcaptionskip=5pt
%
%%
%% Insert \small and remove colon after table/figure number
%\long\def\@makecaption#1#2{%
%  \vskip\abovecaptionskip
%  \small
%  \sbox\@tempboxa{#1 #2}%
%  \ifdim \wd\@tempboxa >\hsize
%    #1 #2\par
%  \else
%    \global \@minipagefalse
%    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
%  \fi
%  \vskip\belowcaptionskip}
%
%\@addtoreset{table}{section}
%\renewcommand\thetable{\thesection.\arabic{table}}
%\def\fnum@table{\tablename\nobreakspace\thetable:}
%
%\@addtoreset{figure}{section}
%\renewcommand\thefigure{\thesection.\arabic{figure}}
%\renewcommand\figurename{Fig.}
%\def\fnum@figure{\figurename\nobreakspace\thefigure.}

\renewcommand{\floatpagefraction}{1}
\floatsep=10pt plus 2.5pt minus 1pt
\textfloatsep=10pt plus 2.5pt minus 1pt
\intextsep=10pt plus 2.5pt minus 1pt
%\doublerulesep=0pt

\abovecaptionskip=3pt
\belowcaptionskip=5pt

%%
%% Insert \small and remove colon after table/figure number
%\long\def\@makecaption#1#2{%
%  \vskip\abovecaptionskip
%  \small
%  \sbox\@tempboxa{#1 #2}%
%  \ifdim \wd\@tempboxa >\hsize
%    #1 #2\par
%  \else
%    \global \@minipagefalse
%    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
%  \fi
%  \vskip\belowcaptionskip}
  
% caption in small font
\long\def\@makecaption#1#2{%
  \renewcommand{\baselinestretch}{0.5}\rm
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\sf \footnotesize #1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    {\sf \footnotesize #1: #2}\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip
  \renewcommand{\baselinestretch}{1}\rm
}  
  
%\@addtoreset{table}{section}
%\renewcommand\thetable{\thesection.\arabic{table}}
%\def\fnum@table{\tablename\nobreakspace\thetable:}
%
%\@addtoreset{figure}{section}
%\renewcommand\thefigure{\thesection.\arabic{figure}}
%\renewcommand\figurename{Fig.}
%\def\fnum@figure{\figurename\nobreakspace\thefigure.}

%======================== Section ===============================
\def\@seccntformat#1{\csname the#1\endcsname. }
\renewcommand\section{\@startsection {section}{1}{\z@}%
                                     %%%{-3.5ex \@plus -1ex \@minus -.2ex}%
                                     {3.5ex \@plus 1ex \@minus .2ex}%
                                     {2.3ex \@plus.2ex}%
                                     {\normalfont\large\bfseries\centering}}
\renewcommand\subsection{\@startsection {subsection}{2}{\z@}%
                                        %%%{-3.25ex\@plus -1ex \@minus -.2ex}%
                                        {3.25ex\@plus 1ex \@minus .2ex}%
                                        {1.5ex \@plus .2ex}%
                                        {\normalfont\large\bfseries}}

%======================== Bibliography ===============================
\renewcommand\@openbib@code{\parsep \z@ \itemsep \z@ \parskip \z@ \small}

%======================== Equation ===================================
% JAH 20090820
%\@addtoreset{equation}{section}
%\renewcommand\theequation{\thesection.\arabic{equation}}

%======================== Theorem, Lemma, etc., and proof ============
%\def\@begintheorem#1#2{\trivlist
%   \item[\hskip \labelsep{\bfseries #1\ #2.}]\itshape}
% JAH 20090820
\newtheorem{theorem}{Theorem}%[section]
\newtheorem{lemma}{Lemma}%[section]
\newtheorem{proposition}{Proposition}%[section]
\newtheorem{corollary}{Corollary}%[section]
\newtheorem{remark}{Remark}%[section]
\newtheorem{definition}{Definition}%[section]
\newtheorem{condition}{Condition}%[section]
\newtheorem{example}{Example}%[section]
\newtheorem{conclusion}{Conclusion}%[section]
\newtheorem{algorithm}{Algorithm}%[section]
\newtheorem{assumption}{Assumption}%[section]

% JAH 20090820
\renewenvironment{proof} {\par{\it Proof.} \ignorespaces} {\par\medskip}

%===========================================================================

 \pagestyle{headings}

% \renewcommand\markboth[2]{
  \def\@evenhead{\thepage\hfill {\hfil\footnotesize\shortauthor\hfill}}

 %\def\@evenhead{\thepage\hfill {\footnotesize\rm #2}}
  \def\@oddhead{{\hfill\footnotesize\shorttitle\hfil}\hfill \thepage}
 
 % \def\@oddhead{{\footnotesize\rm #1} {\footnotesize\rm \journalshortname, {\bf \thisvolume} (\thisyear), pp.~\thispagestart-\thispageend } 

%}

\endinput

