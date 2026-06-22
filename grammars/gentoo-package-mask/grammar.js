/**
 * gentoo-package-mask — tree-sitter grammar for /etc/portage/package.mask and
 * package.unmask files. Each non-comment, non-blank line is just a package
 * atom (no trailing keywords). The original vim syntax inherits everything
 * from gentoo-package-common.vim and adds nothing.
 *
 * Reference: gentoo-syntax/syntax/gentoo-package-mask.vim
 */

module.exports = grammar({
  name: 'gentoo_package_mask',
  extras: $ => [],

  rules: {
    file: $ => repeat(choice($.comment, $.blank_line, $.entry)),

    blank_line: $ => /[ \t]*\n/,

    comment: $ => token(seq('#', /[^\n]*/)),

    entry: $ => seq(optional(/[ \t]+/), $.atom, /[ \t]*/, optional('\n')),

    atom: $ => token(prec(2, /[^\s#\/]+\/[^\s#]+/)),
  },
});
