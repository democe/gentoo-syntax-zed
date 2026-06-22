/**
 * gentoo-package-properties — tree-sitter grammar for /etc/portage/package.properties
 * files. Each non-comment, non-blank line is:
 *
 *   <atom> [property | -property | * | -*]*
 *
 * Reference: gentoo-syntax/syntax/gentoo-package-properties.vim
 */

module.exports = grammar({
  name: 'gentoo_package_properties',
  extras: $ => [],

  rules: {
    file: $ => repeat(choice($.comment, $.blank_line, $.entry)),

    blank_line: $ => /[ \t]*\n/,

    comment: $ => token(seq('#', /[^\n]*/)),

    entry: $ => seq(optional(/[ \t]+/), $.atom, repeat(seq(/[ \t]+/, $.property)), /[ \t]*/, optional('\n')),

    atom: $ => token(prec(2, /[^\s#\/]+\/[^\s#]+/)),

    property: $ => choice($.property_neg, $.property_wild, $.property_name),

    property_neg:  $ => token(prec(2, /-[A-Za-z0-9_-]+/)),
    property_wild: $ => token(prec(3, /\*|\-\*/)),
    property_name: $ => token(prec(1, /[A-Za-z0-9_-]+/)),
  },
});
