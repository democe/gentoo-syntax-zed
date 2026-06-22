; XML highlights for gentoo-nvim.
; Minimal highlights for the tree-sitter-xml grammar, used as the base
; for gentoo-metadata and guidexml via `; inherits: xml`.

(PI) @keyword
(XMLDecl) @keyword
(doctypedecl) @keyword
(element) @tag
(STag (Name) @tag)
(ETag (Name) @tag)
(EmptyElemTag (Name) @tag)
(Attribute (Name) @attribute)
(AttValue) @string
(CharData) @text.literal
(CharRef) @constant
(EntityRef) @constant
(CDSect) @string
(CDStart) @keyword
(Comment) @comment
(PITarget) @keyword
(SystemLiteral (URI) @link_uri)
(ExternalID) @keyword