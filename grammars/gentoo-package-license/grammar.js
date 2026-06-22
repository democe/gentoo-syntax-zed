/**
 * gentoo-package-license — tree-sitter grammar for /etc/portage/package.license
 * files. Each non-comment, non-blank line is:
 *
 *   <atom> [license | -license | @group | -@group | * | -*]*
 *
 * Reference: gentoo-syntax/syntax/gentoo-package-license.vim
 */

module.exports = grammar({
  name: 'gentoo_package_license',
  extras: $ => [],

  rules: {
    file: $ => repeat(choice($.comment, $.blank_line, $.entry)),

    blank_line: $ => /[ \t]*\n/,

    comment: $ => token(seq('#', /[^\n]*/)),

    entry: $ => seq(optional(/[ \t]+/), $.atom, repeat(seq(/[ \t]+/, $.license_spec)), /[ \t]*/, optional('\n')),

    atom: $ => token(prec(2, /[^\s#\/]+\/[^\s#]+/)),

    license_spec: $ => choice($.license_group, $.license_neg, $.license, $.star),

    // @group or -@group
    license_group: $ => token(prec(3, /-?@[A-Za-z0-9_.+-]+/)),

    // -name or -*
    license_neg: $ => token(prec(2, /-([A-Za-z0-9_.+-]+|\*)/)),

    // bare *
    star: $ => token(prec(3, /\*/)),

    // plain license name
    license: $ => token(prec(1, /[A-Za-z0-9_.+-]+/)),
  },
});
