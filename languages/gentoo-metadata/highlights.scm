; inherits: xml
;
; Gentoo metadata.xml highlights layered on the XML grammar.
; Mirrors gentoo-syntax/syntax/gentoo-metadata.vim.
;
; Element names from the metadata.xml DTD get @keyword; the rest of the
; document is highlighted by the inherited xml query.

; Top-level package metadata elements.
((STag (Name) @keyword
  (#any-of? @keyword
    "pkgmetadata" "catmetadata" "pkg" "cat"))
  (#set! "priority" 110))

((ETag (Name) @keyword
  (#any-of? @keyword
    "pkgmetadata" "catmetadata" "pkg" "cat"))
  (#set! "priority" 110))

; Maintainer / description elements.
((STag (Name) @keyword
  (#any-of? @keyword
    "maintainer" "email" "name" "description" "longdescription"
    "herd" "use" "flag"))
  (#set! "priority" 110))

((ETag (Name) @keyword
  (#any-of? @keyword
    "maintainer" "email" "name" "description" "longdescription"
    "herd" "use" "flag"))
  (#set! "priority" 110))

; Upstream metadata elements (GLEP 56).
((STag (Name) @keyword
  (#any-of? @keyword
    "upstream" "changelog" "doc" "bugs-to" "remote-id"))
  (#set! "priority" 110))

((ETag (Name) @keyword
  (#any-of? @keyword
    "upstream" "changelog" "doc" "bugs-to" "remote-id"))
  (#set! "priority" 110))