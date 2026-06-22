; Gentoo make.conf highlights.
; Mirrors gentoo-syntax/syntax/gentoo-make-conf.vim.
;
; Capture mapping:
;   use_keyword / accept_* / cflags_name / etc -> @keyword
;   known_variable                       -> @constant
;   eclass_variable                      -> @function
;   naughty_variable                     -> @hint
;   misc_variable                        -> @keyword
;   quoted_string / bareword_list        -> @string
;   use_flag / arch / license_token / feature -> @keyword
;   flag_token                           -> @string.special
;   var_ref / escape                     -> @keyword
;   bad_sparc_chost / makeopts_bad_j     -> @hint
;   comment                              -> @comment

(comment) @comment

"=" @operator

; Specialised variable names. We match the inner named node so the
; query captures only the keyword token, not the whole variable_name.
(use_keyword) @keyword
(accept_keywords) @keyword
(accept_license) @keyword
(accept_properties) @keyword
(allow_test) @keyword
(cflags_name) @keyword
(ldflags_name) @keyword
(makeopts_name) @keyword
(chost_name) @keyword
(features_name) @keyword
(known_variable) @constant
(eclass_variable) @function
(naughty_variable) @hint
(misc_variable) @keyword

(quoted_string) @string
(bareword_list) @string
(quoted_string "\"" @punctuation.special)

(use_flag) @keyword
(arch) @keyword
(license_token) @keyword
(feature) @keyword
(flag_token) @string.special
(var_ref) @keyword
(escape) @string.escape

(bad_sparc_chost) @hint
(makeopts_bad_j) @hint