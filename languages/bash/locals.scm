; Bash locals for gentoo-nvim.

(variable_assignment
  name: (variable_name) @local.definition)

(function_definition
  name: (word) @local.definition)

((variable_name) @local.reference
  (#not-match? @local.reference "^[A-Z][A-Z_]+$"))