; inherits: rst
;
; Gentoo GLEP highlights layered on the reStructuredText grammar.
; Mirrors gentoo-syntax/syntax/glep.vim.
;
; The rst grammar already highlights section titles, inline markup, etc.
; We add GLEP-specific header / TODO captures on top.

; Section titles (headings).
(section (title) @title)

; GLEP header block at the very top of the file: lines like `Author: ...`,
; `Title: ...`, `Status: ...`, etc. The rst parser sees these as a single
; paragraph; we re-capture it as a keyword block.
((paragraph) @keyword
  (#lua-match? @keyword "^\\(\\(GLEP\\|Title\\|Author\\|Type\\|Status\\|Created\\|Last-Modified\\|Version\\|Content-Type\\)\\s*:"))

; Substitution references like |sample substitution|.
(substitution_reference) @keyword