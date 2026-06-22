/**
 * gentoo-package-keywords — tree-sitter grammar for /etc/portage/package.keywords
 * and package.accept_keywords files. Each non-comment, non-blank line is:
 *
 *   <atom> [keyword | ~keyword | -keyword | * | -*]*
 *
 * Reference: gentoo-syntax/syntax/gentoo-package-keywords.vim
 */

module.exports = grammar({
  name: 'gentoo_package_keywords',
  extras: $ => [],

  rules: {
    file: $ => repeat(choice($.comment, $.blank_line, $.entry)),

    blank_line: $ => /[ \t]*\n/,

    comment: $ => token(seq('#', /[^\n]*/)),

    entry: $ => seq(optional(/[ \t]+/), $.atom, repeat(seq(/[ \t]+/, $.keyword)), /[ \t]*/, optional('\n')),

    atom: $ => token(prec(2, /[^\s#\/]+\/[^\s#]+/)),

    keyword: $ => choice($.all_keyword, $.unstable_keyword, $.stable_keyword),

    // ~arch / ~* / -~arch
    unstable_keyword: $ => token(prec(3, /-?~([a-z0-9-]+|\*)/)),

    // * / -*.
    all_keyword: $ => token(prec(3, /-?\*/)),

    // stable arch: arch or -arch
    stable_keyword: $ => token(prec(1, /-?[a-z0-9-]+/)),
  },
});
