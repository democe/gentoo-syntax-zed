; Gentoo package.license highlights.
; Mirrors gentoo-syntax/syntax/gentoo-package-license.vim.
;
;   license        -> @function  (Special)
;   license_neg    -> @keyword           (Keyword, -license)
;   license_group  -> @type              (Type, @constant / -@constant)
;   star           -> @function  (Special, *)

(comment) @comment
(atom) @function

(license) @function
(license_neg) @keyword
(license_group) @type
(star) @function