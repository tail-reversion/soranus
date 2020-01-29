% soranus.cls
% Copyright (C) 2018-2020 Kelly Smith.
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
\RequirePackage{expl3}[2020/01/22]

\ProvidesExplClass{soranus}{2020/01/25}{0.0.0}
  {An experimental class for, like, papers and books and stuff.}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Package-Related Business
%

%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
% Outdated l3kernel and l3packages
%

\@ifpackagelater { expl3 } { 2020/01/22 }
  { }
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
% (Some) Incompatible Packages
%

\msg_new:nnnn { soranus } { incompatible-package }
  { Package~`#1'~incompatible. }
  { The~package~`#1'~is~incompatible~with~the~soranus~class. }

\seq_const_from_clist:Nn \c__soranus_incompatible_packages_seq
  {
    geometry,
    array, booktabs, longtable,
    amsmath, mathtools,
    titlesec, fancyhdr,
    babel, polyglossia,
    hyperref
  }

\cs_new_protected:Nn \__soranus_load_check:
  {
    \seq_map_inline:Nn \c__soranus_incompatible_packages_seq
      {
        \@ifpackageloaded { ##1 }
          { \msg_error:nnn { soranus } { incompatible-package } { ##1 } }
          { }
      }
  }

\AtBeginDocument { \__soranus_load_check: }


%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
% Load Packages and Modules
%

\RequirePackage { xparse, xtemplate, xgalley, xcoffins, l3keys2e }
\RequirePackage { calc, etoolbox, lmodern }

% The load order is critical!!!
\file_input:n { utility.tex }
\file_input:n { metadata.tex }
\file_input:n { docparams.tex }
\file_input:n { fontsize.tex }
\file_input:n { pagelayout.tex }
\file_input:n { pagestyle.tex }
\file_input:n { title.tex }



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Class Options (Document Parameters)
%

\keys_define:nn { soranus }
  {
    class-options .inherit:n =
      {
        soranus / font-size,
        soranus / paper-and-trim
      }
  }

\keys_define:nn { soranus / class-options }
  {
    paper .choice:,
    paper / a2 .meta:n = { paper-width = 420mm, paper-height = 594mm },
    paper / a3 .meta:n = { paper-width = 297mm, paper-height = 420mm },
    paper / a4 .meta:n = { paper-width = 210mm, paper-height = 297mm },
    paper / a5 .meta:n = { paper-width = 148mm, paper-height = 210mm },
    paper / a6 .meta:n = { paper-width = 105mm, paper-height = 148mm },

    paper / b2 .meta:n = { paper-width = 500mm, paper-height = 707mm },
    paper / b3 .meta:n = { paper-width = 353mm, paper-height = 500mm },
    paper / b4 .meta:n = { paper-width = 250mm, paper-height = 353mm },
    paper / b5 .meta:n = { paper-width = 176mm, paper-height = 250mm },
    paper / b6 .meta:n = { paper-width = 125mm, paper-height = 176mm },

    paper / c2 .meta:n = { paper-width = 458mm, paper-height = 648mm },
    paper / c3 .meta:n = { paper-width = 324mm, paper-height = 458mm },
    paper / c4 .meta:n = { paper-width = 229mm, paper-height = 324mm },
    paper / c5 .meta:n = { paper-width = 162mm, paper-height = 229mm },
    paper / c6 .meta:n = { paper-width = 114mm, paper-height = 162mm },

    paper / din-d2 .meta:n = { paper-width = 385mm, paper-height = 545mm },
    paper / din-d3 .meta:n = { paper-width = 172mm, paper-height = 385mm },
    paper / din-d4 .meta:n = { paper-width = 192mm, paper-height = 272mm },
    paper / din-d5 .meta:n = { paper-width = 136mm, paper-height = 192mm },
    paper / din-d6 .meta:n = { paper-width = 96mm, paper-height = 136mm },

    paper / jis-b2 .meta:n = { paper-width = 515mm, paper-height = 728mm },
    paper / jis-b3 .meta:n = { paper-width = 364mm, paper-height = 515mm },
    paper / jis-b4 .meta:n = { paper-width = 257mm, paper-height = 364mm },
    paper / jis-b5 .meta:n = { paper-width = 182mm, paper-height = 257mm },
    paper / jis-b6 .meta:n = { paper-width = 128mm, paper-height = 182mm },

    paper / half-letter       .meta:n = { paper-width = 5.5in, paper-height = 8.5in },
    paper / letter            .meta:n = { paper-width = 8.5in, paper-height = 11in },
    paper / government-letter .meta:n = { paper-width = 8in, paper-height = 10.25in },
    paper / junior-legal      .meta:n = { paper-width = 5in, paper-height = 8in },
    paper / government-legal  .meta:n = { paper-width = 8.5in, paper-height = 13in },
    paper / legal             .meta:n = { paper-width = 8.5in, paper-height = 14in },
    paper / tabloid           .meta:n = { paper-width = 11in, paper-height = 17in },
    paper / ledger            .meta:n = { paper-width = 17in, paper-height = 11in },
    paper / broadsheet        .meta:n = { paper-width = 17in, paper-height = 22in },

    paper / unknown .code:n =
      { \msg_error:nnnn { soranus } { unknown-choice } { paper } { #1 } },

    paper .value_required:n = true
  }


\NewDocumentCommand \DocumentSetup { m }
  {
    \keys_set:nn { soranus / class-options } { #1 }
  }

\@onlypreamble \DocumentSetup


% Initialize the document.
\__soranus_set_pagelayout:n { }
