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

\@ifpackagelater {expl3} {2018/02/21}
  {}
  {
    \ClassError {soranus} {Support~package~expl3~too~old}
      {
        You~need~to~update~your~installation~of~the~bundles~`l3kernel'~and~
        `l3packages'.\MessageBreak
        Loading~class~siunitx~will~abort!
      }
    \tex_endinput:D
  }


\msg_new:nnnn {soranus} {incompatible-package}
  {Package~`#1'~incompatible.}
  {The~#1~package~and~the~soranus~class~are~incompatible.}

\cs_new_protected:Nn \__soranus_load_check:n
  {
    \group_begin:
      \@ifpackageloaded {#1}
        {\msg_error:nnx {soranus} {incompatible-package} {#1}}
        {}
    \group_end:
  }

\clist_const:Nn \c__soranus_incompatible_packages_clist
  {changepage, enumitem, fancyhdr, geometry}

\AtBeginDocument
  {\clist_map_function:NN \c__soranus_incompatible_packages_clist \__soranus_load_check:n}



\RequirePackage{l3keys2e,xcoffins,xgalley,xparse,xtemplate}
\RequirePackage{lmodern}


\input{utility.tex}
\input{fontsize.tex}
\input{pagelayout.tex}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Class Options And Core Layout
%

\keys_define:nn {soranus}
  {
    point-size .code:n           = {\__soranus_set_document_point_size:n {#1}},
    point-size .value_required:n = true,
    point-size .initial:n        = 10pt,


    baseline-scale .fp_gset:N        = \g__soranus_baseline_scale_fp,
    baseline-scale .value_required:n = true,
    baseline-scale .initial:n        = 1.2,


    paper-width .dim_gset:N       = \g__soranus_paper_width_dim,
    paper-width .value_required:n = true,

    paper-height .dim_gset:N       = \g__soranus_paper_height_dim,
    paper-height .value_required:n = true,


    paper .choice:,

    paper / a2 .meta:n = {paper-width = 420mm, paper-height = 594mm},
    paper / a3 .meta:n = {paper-width = 297mm, paper-height = 420mm},
    paper / a4 .meta:n = {paper-width = 210mm, paper-height = 297mm},
    paper / a5 .meta:n = {paper-width = 148mm, paper-height = 210mm},
    paper / a6 .meta:n = {paper-width = 105mm, paper-height = 148mm},

    paper / b2 .meta:n = {paper-width = 500mm, paper-height = 707mm},
    paper / b3 .meta:n = {paper-width = 353mm, paper-height = 500mm},
    paper / b4 .meta:n = {paper-width = 250mm, paper-height = 353mm},
    paper / b5 .meta:n = {paper-width = 176mm, paper-height = 250mm},
    paper / b6 .meta:n = {paper-width = 125mm, paper-height = 176mm},

    paper / c2 .meta:n = {paper-width = 458mm, paper-height = 648mm},
    paper / c3 .meta:n = {paper-width = 324mm, paper-height = 458mm},
    paper / c4 .meta:n = {paper-width = 229mm, paper-height = 324mm},
    paper / c5 .meta:n = {paper-width = 162mm, paper-height = 229mm},
    paper / c6 .meta:n = {paper-width = 114mm, paper-height = 162mm},

    paper / din-d2 .meta:n = {paper-width = 385mm, paper-height = 545mm},
    paper / din-d3 .meta:n = {paper-width = 172mm, paper-height = 385mm},
    paper / din-d4 .meta:n = {paper-width = 192mm, paper-height = 272mm},
    paper / din-d5 .meta:n = {paper-width = 136mm, paper-height = 192mm},
    paper / din-d6 .meta:n = {paper-width = 96mm, paper-height = 136mm},

    paper / jis-b2 .meta:n = {paper-width = 515mm, paper-height = 728mm},
    paper / jis-b3 .meta:n = {paper-width = 364mm, paper-height = 515mm},
    paper / jis-b4 .meta:n = {paper-width = 257mm, paper-height = 364mm},
    paper / jis-b5 .meta:n = {paper-width = 182mm, paper-height = 257mm},
    paper / jis-b6 .meta:n = {paper-width = 128mm, paper-height = 182mm},

    paper / half-letter       .meta:n = {paper-width = 5.5in, paper-height = 8.5in},
    paper / letter            .meta:n = {paper-width = 8.5in, paper-height = 11in},
    paper / government-letter .meta:n = {paper-width = 8in, paper-height = 10.25in},
    paper / junior-legal      .meta:n = {paper-width = 5in, paper-height = 8in},
    paper / government-legal  .meta:n = {paper-width = 8.5in, paper-height = 13in},
    paper / legal             .meta:n = {paper-width = 8.5in, paper-height = 14in},
    paper / tabloid           .meta:n = {paper-width = 11in, paper-height = 17in},
    paper / ledger            .meta:n = {paper-width = 17in, paper-height = 11in},
    paper / broadsheet        .meta:n = {paper-width = 17in, paper-height = 22in},

    paper .value_required:n = true,
    paper .initial:n        = a4,


    landscape .bool_gset:N       = \g__soranus_landscape_bool,
    landscape .value_forbidden:n = true,
    landscape .initial:n         = false,
    landscape .default:n         = true
  }


\ProcessKeysOptions {soranus}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
%

\bool_if:nT {\g__soranus_landscape_bool}
  {
    \dim_set_eq:NN \l_soranus_tmpa_dim \g__soranus_paper_width_dim
    \dim_gset_eq:NN \g__soranus_paper_width_dim \g__soranus_paper_height_dim
    \dim_gset_eq:NN \g__soranus_paper_height_dim \l_soranus_tmpa_dim
  }

% Hard code text width until pagelayout.tex is functional.
\dim_gset:Nn \g__soranus_text_width_dim {30pc}
\dim_gset:Nn \g__soranus_text_height_dim {50pc}
