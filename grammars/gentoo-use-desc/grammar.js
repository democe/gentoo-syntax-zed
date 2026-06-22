/**
 * gentoo-use-desc — tree-sitter grammar for profiles/use.desc and
 * use.local.desc files. Format:
 *
 *   use.desc:        flag - description
 *   use.local.desc:  cat/pkg:flag - description
 *
 * Reference: gentoo-syntax/syntax/gentoo-use-desc.vim
 */

module.exports = grammar({
  name: 'gentoo_use_desc',
  extras: $ => [],

  rules: {
    file: $ => repeat(choice($.comment, $.blank_line, $.entry)),

    blank_line: $ => /[ \t]*\n/,

    comment: $ => token(seq('#', /[^\n]*/)),

    entry: $ => seq(
      optional($.package),
      $.flag,
      $.separator,
      optional($.description),
      optional('\n'),
    ),

    // 'cat/pkg:' prefix for use.local.desc.
    package: $ => token(prec(2, /[A-Za-z0-9_.+-]+\/[A-Za-z0-9_.+-]+:/)),

    // Use flag name (no whitespace, no dash-separator). Use flags may
    // contain letters, digits, _, -, +, @, :, .
    flag: $ => token(prec(2, /[A-Za-z0-9_+@:.-]+/)),

    // The ' - ' separator.
    separator: $ => token(seq(/[ \t]+-/, /[ \t]+/)),

    // Free-text description to end of line.
    description: $ => token(prec(3, /[^\n]+/)),
  },
});
