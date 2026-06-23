/**
 * gentoo-package-use — tree-sitter grammar for /etc/portage/package.use and
 * package.env files. Each non-comment, non-blank line is:
 *
 *   <atom> <use_flag> | -<use_flag> | <use_expand>:  (zero or more)
 *
 * where <atom> is cat/pkg, cat/pkg:slot, cat/pkg-1.2, star/pkg, etc.
 *
 * Reference: gentoo-syntax/syntax/gentoo-package-use.vim
 */

module.exports = grammar({
  name: 'gentoo_package_use',
  extras: $ => [/[ \t]+/],

  rules: {
    file: $ => repeat(choice($.comment, $.blank_line, $.entry)),

    blank_line: $ => '\n',

    comment: $ => token(seq('#', /[^\n]*/, optional('\n'))),

    entry: $ => seq($.atom, repeat($.use_spec)),

    // Package atom: cat/pkg with optional :slot, -version, wildcards.
    // Anything up to the first whitespace after a slash.
    atom: $ => token(prec(2, /[^\n \t#\/]+\/[^\n \t#]+/)),

    use_spec: $ => choice($.use_expand, $.use_disabled, $.use_flag),

    // USE_EXPAND: a 'category:' token (trailing colon).
    use_expand: $ => token(prec(2, /[A-Za-z0-9][A-Za-z0-9_-]*:/)),

    // +flag (rare in package.use but allowed by the original grammar).
    use_flag: $ => token(prec(1, choice(/[A-Za-z0-9][A-Za-z0-9_-]*/, /[*]/))),

    // -flag / -star
    use_disabled: $ => token(prec(2, seq('-', choice(/[A-Za-z0-9][A-Za-z0-9_-]*/, /[*]/)))),
  },
});
