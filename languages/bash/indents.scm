; Bash indents for gentoo-nvim.
; Provides tree-sitter-based indentation for bash-based Gentoo filetypes.

[
  (if_statement)
  (for_statement)
  (while_statement)
  (c_style_for_statement)
  (case_statement)
  (case_item)
  (function_definition)
  (command_substitution)
  (subshell)
  (do_group)
  (elif_clause)
  (else_clause)
] @indent.begin

[
  "fi"
  "done"
  "esac"
  "}"
  ")"
  "]"
] @indent.end

[
  "fi"
  "done"
  "esac"
  "}"
] @indent.branch

((comment) @indent.auto)
((string) @indent.auto)