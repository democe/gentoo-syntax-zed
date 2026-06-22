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
  extras: $ => [],

  rules: {
    file: $ => repeat(choice($.comment, $.blank_line, $.entry)),

    blank_line: $ => /[ \t]*\n/,

    comment: $ => token(seq('#', /[^\n]*/)),

    entry: $ => seq(optional(/[ \t]+/), $.atom, repeat(seq(/[ \t]+/, $.use_spec)), /[ \t]*/, optional('\n')),

    // Package atom: cat/pkg with optional :slot, -version, wildcards.
    // Anything up to the first whitespace after a slash.
    atom: $ => token(prec(2, /[^\s#\/]+\/[^\s#]+/)),

    use_spec: $ => choice($.use_expand_spec, $.use_flag, $.use_disabled),

    use_expand_spec: $ => seq($.use_expand, optional(choice($.use_flag, $.use_disabled))),

    // USE_EXPAND: a 'category:' token (trailing colon).
    use_expand: $ => token(prec(2, /[A-Za-z0-9][A-Za-z0-9_-]*:/)),

    // +flag (rare in package.use but allowed by the original grammar).
    use_flag: $ => token(prec(1, choice(/[A-Za-z0-9][A-Za-z0-9_-]*/, /[*]/))),

    // -flag / -star
    use_disabled: $ => token(prec(2, seq('-', choice(/[A-Za-z0-9][A-Za-z0-9_-]*/, /[*]/)))),
  },
});
