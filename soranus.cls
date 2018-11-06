% soranus.cls
% Copyright (C) 2018 Kelly Smith.
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
\RequirePackage{expl3}[2018/02/21]

\ProvidesExplClass{soranus}{2018/10/06}{0.0.0}
  {A modern, flexible class for articles, reports, and books of all sorts.}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Package-Related Business
%

%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
% Outdated l3kernel and l3packages
%

\@ifpackagelater { expl3 } { 2018/02/21 }
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
% Incompatible Packages
%
% This list is nonexhaustive but covers the essentials.

\msg_new:nnnn { soranus } { incompatible-package }
  { Package~`#1'~incompatible. }
  { The~#1~package~and~the~soranus~class~are~incompatible. }

\cs_new_protected:Nn \__soranus_load_check:n
  {
    \group_begin:
      \@ifpackageloaded { #1 }
        { \msg_error:nnn { soranus } { incompatible-package } { #1 } }
        { }
    \group_end:
  }

\clist_const:Nn \c__soranus_incompatible_packages_clist
  { changepage, crop, enumitem, fancyhdr, geometry, sidecap, titleps, titlesec, titletoc }

\clist_map_function:NN \c__soranus_incompatible_packages_clist \__soranus_load_check:n

\AtBeginDocument
  { \clist_map_function:NN \c__soranus_incompatible_packages_clist \__soranus_load_check:n }


%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
% Load Packages and Modules
%

\RequirePackage { l3keys2e, xparse, xtemplate }
\RequirePackage { etoolbox, lmodern }

% The load order is critical!!!
\file_input:n { utility.tex }
\file_input:n { docparams.tex }
\file_input:n { classoptions.tex }
\file_input:n { fontsize.tex }
\file_input:n { pagelayout.tex }
\file_input:n { metadata.tex }



% Initialize the document.
\ProcessKeysOptions { soranus / docparams }
\__soranus_init_document_point_size:
\__soranus_init_paper_and_trim:
\UsePageLayout { thepagelayout }
