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

\@ifpackagelater {expl3} {2018/02/21}
  {}
  {
    \ClassError {soranus} {Support~package~expl3~too~old}
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
  {changepage, crop, enumitem, fancyhdr, geometry, sidecap, titleps, titlesec, titletoc}

\AtBeginDocument
  {\clist_map_function:NN \c__soranus_incompatible_packages_clist \__soranus_load_check:n}


%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
% Load Packages and Modules

\RequirePackage{l3keys2e,xcoffins,xgalley,xparse,xtemplate}
\RequirePackage{lmodern}

\input{utility.tex}
\input{fontsize.tex}
\input{pagelayout.tex}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Class Options And Core Layout
%

\msg_new:nnnn {soranus} {unknown-choice}
  {Key~`#1'~given~unknown~value~#2.}
  {You~gave~the~key~`#1'~the~unknown~value~#2.~Accepted~values~are:~#3.}



\keys_define:nn {soranus/advanced}
  {
    paper-size .code:n           =
      {\soranus_apply_comma_pair:Nn \__soranus_set_paper_size:nn {#1}},
    paper-size .value_required:n = true,


    paper .choice:,

    paper / a2 .meta:n = {paper-size = {420mm, 594mm}},
    paper / a3 .meta:n = {paper-size = {297mm, 420mm}},
    paper / a4 .meta:n = {paper-size = {210mm, 297mm}},
    paper / a5 .meta:n = {paper-size = {148mm, 210mm}},
    paper / a6 .meta:n = {paper-size = {105mm, 148mm}},

    paper / b2 .meta:n = {paper-size = {500mm, 707mm}},
    paper / b3 .meta:n = {paper-size = {353mm, 500mm}},
    paper / b4 .meta:n = {paper-size = {250mm, 353mm}},
    paper / b5 .meta:n = {paper-size = {176mm, 250mm}},
    paper / b6 .meta:n = {paper-size = {125mm, 176mm}},

    paper / c2 .meta:n = {paper-size = {458mm, 648mm}},
    paper / c3 .meta:n = {paper-size = {324mm, 458mm}},
    paper / c4 .meta:n = {paper-size = {229mm, 324mm}},
    paper / c5 .meta:n = {paper-size = {162mm, 229mm}},
    paper / c6 .meta:n = {paper-size = {114mm, 162mm}},

    paper / din-d2 .meta:n = {paper-size = {385mm, 545mm}},
    paper / din-d3 .meta:n = {paper-size = {172mm, 385mm}},
    paper / din-d4 .meta:n = {paper-size = {192mm, 272mm}},
    paper / din-d5 .meta:n = {paper-size = {136mm, 192mm}},
    paper / din-d6 .meta:n = {paper-size = {96mm, 136mm}},

    paper / jis-b2 .meta:n = {paper-size = {515mm, 728mm}},
    paper / jis-b3 .meta:n = {paper-size = {364mm, 515mm}},
    paper / jis-b4 .meta:n = {paper-size = {257mm, 364mm}},
    paper / jis-b5 .meta:n = {paper-size = {182mm, 257mm}},
    paper / jis-b6 .meta:n = {paper-size = {128mm, 182mm}},

    paper / half-letter       .meta:n = {paper-size = {5.5in, 8.5in}},
    paper / letter            .meta:n = {paper-size = {8.5in, 11in}},
    paper / government-letter .meta:n = {paper-size = {8in, 10.25in}},
    paper / junior-legal      .meta:n = {paper-size = {5in, 8in}},
    paper / government-legal  .meta:n = {paper-size = {8.5in, 13in}},
    paper / legal             .meta:n = {paper-size = {8.5in, 14in}},
    paper / tabloid           .meta:n = {paper-size = {11in, 17in}},
    paper / ledger            .meta:n = {paper-size = {17in, 11in}},
    paper / broadsheet        .meta:n = {paper-size = {17in, 22in}},

    paper / unknown .code:n =
      {
        \msg_error:nnnnn {soranus} {unknown-choice}
          {paper}
          {#1}
          {
            a2,~a3,~a4,~a5,~a6,~
            b2,~b3,~b4,~b5,~b6,~
            c2,~c3,~c4,~c5,~c6,~
            din-d2,~din-d3,~din-d4,~din-d5,~din-d6,~
            jis-b2,~jis-b3,~jis-b4,~jis-b5,~jis-b6,~
            half-letter,~letter,~government-letter,~
            junior-legal,~government-legal,~legal,~
            tabloid,~ledger,~broadsheet
          }
      },

    paper .value_required:n = true,


    trim .code:n           =
      {\soranus_apply_comma_pair:Nn \__soranus_set_page_trim:nn {#1}},
    trim .value_required:n = true,
    trim .initial:n        = 0pt,


    page-size .code:n           =
      {\soranus_apply_comma_pair:Nn \__soranus_set_page_size:nn {#1}},
    page-size .value_required:n = true,
    page-size .initial:n        = {297mm, 420mm},


    point-size .dim_gset:N       = \g__soranus_point_size_dim,
    point-size .value_required:n = true,


    baseline-scale .fp_gset:N        = \g__soranus_baseline_scale_fp,
    baseline-scale .value_required:n = true,
    baseline-scale .initial:n        = 1.2,


    notrim .meta:n            =
      {
        page-size = {\g__soranus_paper_width_dim, \g__soranus_paper_height_dim},
        trim = 0pt
      },
    notrim .value_forbidden:n = true,


    landscape .bool_gset:N = \g__soranus_landscape_bool,


    twoside .bool_gset:N = \g__soranus_twoside_bool,
  }



\keys_define:nn {soranus}
  {
    point-size .meta:nn          = {soranus/advanced} {point-size = #1},
    point-size .value_required:n = true,
    point-size .initial:n        = 10pt,


    paper .meta:nn          = {soranus/advanced} {paper = #1, notrim},
    paper .value_required:n = true,
    paper .initial:n        = a4,


    landscape .meta:nn          = {soranus/advanced} {landscape = #1},
    landscape .value_required:n = false,
    landscape .initial:n        = false,
    landscape .default:n        = true,


    twoside .meta:nn          = {soranus/advanced} {twoside = #1},
    twoside .value_required:n = false,
    twoside .initial:n        = false,
    twoside .default:n        = true
  }


\ProcessKeysOptions {soranus}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization Commands
%

\cs_new:Nn \__soranus_init:
  {
    \__soranus_init_document_point_size:

    \bool_if:nT {\g__soranus_landscape_bool}
      {
        \dim_set_eq:NN \l_soranus_tmpa_dim \g__soranus_paper_width_dim
        \dim_gset_eq:NN \g__soranus_paper_width_dim \g__soranus_paper_height_dim
        \dim_gset_eq:NN \g__soranus_paper_height_dim \l_soranus_tmpa_dim
      }

    \bool_if:NTF {\g__soranus_twoside_bool}
      {\@twosidetrue}
      {\@twosidefalse}
  }


\NewDocumentCommand \SetClassOptions {m}
  {
    \keys_set:nn {soranus/advanced} {#1}
    \__soranus_init:
  }

\@onlypreamble {\SetClassOptions}



% Initialize the document.
\__soranus_init:
\AtBeginDocument {\UseInstance {pagelayout} {thepagelayout}}
