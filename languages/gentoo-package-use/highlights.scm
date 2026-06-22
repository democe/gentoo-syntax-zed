; Gentoo package.use highlights.
; Mirrors gentoo-syntax/syntax/gentoo-package-use.vim and
; gentoo-package-common.vim.
;
; Capture mapping:
;   comment        -> @comment
;   atom           -> @function          (Identifier)
;   use_flag       -> @function  (Special)
;   use_disabled   -> @keyword           (Keyword, -flag)
;   use_expand     -> @type              (Type, USE_EXPAND category:)

(comment) @comment

(atom) @function

(use_expand) @type
(use_flag) @function
(use_disabled) @keyword