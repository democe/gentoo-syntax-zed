; Gentoo package.keywords highlights.
; Mirrors gentoo-syntax/syntax/gentoo-package-keywords.vim.
;
;   unstable_keyword (~arch) -> @keyword          (Keyword)
;   stable_keyword  (arch)    -> @function (Special)
;   all_keyword     (* / **)  -> @type             (Type)

(comment) @comment
(atom) @function

(unstable_keyword) @keyword
(stable_keyword) @function
(all_keyword) @type