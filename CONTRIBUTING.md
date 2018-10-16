# Contributing

Thank-you for your interest in the Soranus class! You can contribute by submitting a pull request or by posting an issue. Please check the [Issues](https://github.com/tail-reversion/soranus/issues) and [Projects](https://github.com/tail-reversion/soranus/projects) tabs to see if a desired feature or fix is already under discussion or planned. If you have any questions, you can contact the developer (me) at kellysmith12.21@gmail.com.

## Style Guide

This is a LaTeX3 class, so code should be written in the expl3 language, following the standard style defined by the LaTeX3 team (see `texdoc expl3` for an overview). The class namespace is `soranus`, and `xtemplate` variables should have the namespace `soranus_templatename`. When it is necessary to use a TeX primitive, define a wrapper command (_e.g._ wrap `\tex_pagewidth:D` as `\g__soranus_paper_width_dim`).
