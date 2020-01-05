% soranus.cls
% Copyright (C) 2018-2019 Kelly Smith.
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License (LPPL),
% either version 1.3c of this license or (at your option)
% any later version. The latest version of this license
% is in the file:
%
%   http://www.latex-project.org/lppl.txt
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is Kelly Smith.
%
% This work consists of the files listed in the README.

\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}[2019/11/07]

\ProvidesExplClass{soranus}{2020/01/04}{0.0.0}
  {An experimental class for, like, papers and books and stuff.}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Package-Related Business
%

%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
% Outdated l3kernel and l3packages
%

\@ifpackagelater { expl3 } { 2019/11/07 }
  {}
  {
    \ClassError { soranus } { Support~package~expl3~too~old }
      {
        You~need~to~update~your~installation~of~the~bundles~`l3kernel'~and~
        `l3packages'.\MessageBreak
        Loading~class~soranus~will~abort!
      }
    \tex_endinput:D
  }


%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
% General Warning
%

\msg_new:nnn { soranus } { experimental }
  {
    The~soranus~class~is~a~highly~experimental~work-in-progress~
    and~is~incompatible~with~most~packages.~Do~not~use~in~production!
  }

\msg_warning:nn { soranus } { experimental }


%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
% Load Packages and Modules
%

\RequirePackage { xparse, xtemplate, xcoffins, l3keys2e }
\RequirePackage { calc, etoolbox, lmodern }

% The load order is critical!!!
\file_input:n { utility.tex }
\file_input:n { metadata.tex }
\file_input:n { docparams.tex }
\file_input:n { classoptions.tex }
\file_input:n { fontsize.tex }
\file_input:n { pagelayout.tex }
\file_input:n { pagestyle.tex }



% Initialize the document.
\ProcessKeysOptions { soranus / class-options }
\__soranus_init_document_point_size:
\__soranus_init_paper_and_trim:
