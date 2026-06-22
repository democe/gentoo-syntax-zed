; inherits: xml
;
; Gentoo GuideXML highlights layered on the XML grammar.
; Mirrors gentoo-syntax/syntax/guidexml.vim.
;
; All GuideXML element and attribute names get @keyword, overriding the
; generic XML element highlight with higher priority.

((STag (Name) @keyword
  (#any-of? @keyword
    "mainpage" "guide" "news" "title" "subtitle" "poster" "author"
    "abstract" "summary" "license" "glsaindex" "glsa-latest" "version"
    "date" "chapter" "section" "body" "figure" "fig" "img" "br" "note"
    "impo" "warn" "pre" "p" "table" "tcolumn" "tr" "th" "ti" "ul" "ol"
    "li" "b" "brite" "c" "comment" "e" "i" "path" "mail" "uri" "dl" "dt"
    "dd" "newsitem" "sup" "sub" "keyword" "ident" "const" "stmt" "var"
    "book" "part" "include" "sections" "subsection" "keyval" "values"
    "key" "metadoc" "members" "lead" "member" "categories" "cat" "files"
    "file" "docs" "doc" "memberof" "fileid" "bugs" "bug" "dynamic"
    "intro" "listing" "list" "catid" "overview" "inserts" "insert"
    "docdate"))
  (#set! "priority" 110))

((ETag (Name) @keyword
  (#any-of? @keyword
    "mainpage" "guide" "news" "title" "subtitle" "poster" "author"
    "abstract" "summary" "license" "glsaindex" "glsa-latest" "version"
    "date" "chapter" "section" "body" "figure" "fig" "img" "br" "note"
    "impo" "warn" "pre" "p" "table" "tcolumn" "tr" "th" "ti" "ul" "ol"
    "li" "b" "brite" "c" "comment" "e" "i" "path" "mail" "uri" "dl" "dt"
    "dd" "newsitem" "sup" "sub" "keyword" "ident" "const" "stmt" "var"
    "book" "part" "include" "sections" "subsection" "keyval" "values"
    "key" "metadoc" "members" "lead" "member" "categories" "cat" "files"
    "file" "docs" "doc" "memberof" "fileid" "bugs" "bug" "dynamic"
    "intro" "listing" "list" "catid" "overview" "inserts" "insert"
    "docdate"))
  (#set! "priority" 110))

; GuideXML attributes.
((Attribute (Name) @keyword
  (#any-of? @keyword
    "author" "caption" "category" "test" "parent" "gentoo" "id" "lang"
    "by" "linkto" "link" "short" "src" "title" "colspan" "rowspan"
    "type" "disclaimer" "redirect" "width" "align" "mail" "fullname"
    "vpart" "vchap" "stopper" "arch" "href" "metadoc" "name"))
  (#set! "priority" 110))