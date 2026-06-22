; RST highlights for gentoo-nvim.
; Minimal highlights for the tree-sitter-rst grammar, used as the base
; for glep via `; inherits: rst`.

(title) @title
(section) @title

(paragraph) @text.literal
(literal) @text.literal
(emphasis) @emphasis
(strong) @emphasis.strong
(interpreted_text) @link_text
(inline_target) @link_text
(footnote_reference) @link_text
(substitution_reference) @link_text
(reference) @link_text
(link) @link_text
(standalone_hyperlink) @link_uri

(comment) @comment
(block_quote) @text.literal
(literal_block) @text.literal
(directive) @keyword
(substitution) @keyword
(substitution_definition) @keyword

(bullet_list) @punctuation.list_marker
(list_item) @punctuation.list_marker
(enumerated_list) @punctuation.list_marker

(footnote) @link_text
(citation) @link_text
(label) @link_text

(line_block) @text.literal
(line) @text.literal
(transition) @punctuation.special
(target) @keyword

(field_list) @punctuation.list_marker
(field) @punctuation.list_marker
(field_name) @label
(field_body) @text.literal

(definition_list) @punctuation.list_marker
(definition) @text.literal
(term) @label
(classifier) @label

(attribution) @emphasis

(doctest_block) @text.literal
(arguments) @text.literal
(role) @keyword
(name) @label
(options) @label
(content) @text.literal