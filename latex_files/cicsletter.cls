%
% cicsletter.cls -- a document class based on Nesime Tatbul (tatbul@cs.brown.edu)'s Brown University LaTeX Template
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cicsletter}
\RequirePackage{graphicx}
\RequirePackage{ifthen}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions
\LoadClass[letterpaper]{letter} % we always use letter paper

\newcommand{\subjectname}{Subject}
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{\subjectname: #1}}

\setlength{\textwidth}{6.875in}
\setlength{\textheight}{7.5in}
\setlength{\topskip}{0.0in}
\setlength{\footskip}{.5in}
\setlength{\oddsidemargin}{-0.25in}
\setlength{\evensidemargin}{-0.25in}
\setlength{\topmargin}{-0.875in}

\DeclareFixedFont{\ixcmrmn}{OT1}{cmr}{m}{n}{9}

\newsavebox{\departmenthead}
\newsavebox{\departmentfoot}

\sbox{\departmenthead}{
    \parbox{8.5in}{
           %{\epsfig{file=letterhead.eps, height=0.8088235294in, width=\textwidth}}
           {\includegraphics[width=6.65in, height=0.76in]{letterhead.pdf}}
           
    }
}

\savebox{\departmentfoot}[6.4in][c]{\ixcmrmn
    
    Manning College of Information and Computer Sciences $\bullet$
    140 Governors Dr $\bullet$
    Amherst, MA 01003-9264 $\bullet$
    cics.umass.edu $\bullet$

}




\renewcommand{\ps@firstpage}{
    \setlength{\headheight}{1in}
    \setlength{\headsep}{1.0in}
    \renewcommand{\@oddhead}{\usebox{\departmenthead}}
    \renewcommand{\@oddfoot}{\usebox{\departmentfoot} \footnotesize Page \thepage}
}

\newcommand{\topheader}{
    \setlength{\headheight}{1in}
    \setlength{\headsep}{1.0in}
    \renewcommand{\@oddhead}{\usebox{\departmenthead}}
    \renewcommand{\@oddfoot}{\usebox{\departmentfoot} \footnotesize Page \thepage}
}


\topheader


% we add the subject command to the opening
\renewcommand{\opening}[1]{\thispagestyle{firstpage}%
    \ifx\@empty\fromaddress
        {\raggedleft\@date\par}%
    \else  % home address
        {\raggedleft
            \begin{tabular}{l@{}}\ignorespaces
            \fromaddress \\ *[1\parskip]%
            \@date 
            \end{tabular}\par
        }%
     \fi
     \vspace{1\parskip}%
     {\raggedright \toname \\ \toaddress \par}%
     \vspace{1\parskip}%
     \ifthenelse{\equal{\@subject}{}}{}{\@subject\par}
     \vspace{1\parskip}%
     #1\par\nobreak
}

% we push closing to the right
\renewcommand{\closing}[1]{\par\nobreak\vspace{\parskip}%
    \stopbreaks
    \noindent
    \hspace*{0.6\textwidth}\parbox{0.4\textwidth}{\raggedright
    \ignorespaces #1\\[4\medskipamount]%
    \ifx\@empty\fromsig
        \fromname
    \else \fromsig 
    \fi\strut}%
    \par
}