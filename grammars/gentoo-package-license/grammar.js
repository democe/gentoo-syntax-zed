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
  extras: $ => [/[ \t]+/],

  rules: {
    file: $ => repeat(choice($.comment, $.blank_line, $.entry)),

    blank_line: $ => '\n',

    comment: $ => token(seq('#', /[^\n]*/, optional('\n'))),

    entry: $ => seq($.atom, repeat($.license_spec)),

    atom: $ => token(prec(2, /[^\n \t#\/]+\/[^\n \t#]+/)),

    license_spec: $ => choice($.license_expand, $.license_group, $.license_neg, $.license, $.star),

    // ACCEPT_LICENSE: prefix used in package.license directory entries.
    license_expand: $ => token(prec(3, /[A-Za-z0-9][A-Za-z0-9_-]*:/)),

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
