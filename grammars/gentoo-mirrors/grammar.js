/**
 * gentoo-mirrors — tree-sitter grammar for /etc/portage/thirdpartymirrors
 * and portage/mirrors files. One entry per line:
 *
 *   <category> <url> <url> ...
 *
 * Reference: gentoo-syntax/syntax/gentoo-mirrors.vim
 */

module.exports = grammar({
  name: 'gentoo_mirrors',
  extras: $ => [],

  rules: {
    file: $ => repeat(choice($.comment, $.blank_line, $.entry)),

    blank_line: $ => /[ \t]*\n/,

    comment: $ => token(seq('#', /[^\n]*/)),

    entry: $ => seq(optional(/[ \t]+/), $.category, repeat1(seq(/[ \t]+/, $.url)), /[ \t]*/, optional('\n')),

    category: $ => token(prec(2, /[A-Za-z0-9_.+-]+/)),

    url: $ => choice($.http_url, $.https_url, $.ftp_url, $.generic_url),

    // URL tokens stop at whitespace or end of line.
    http_url:  $ => token(prec(3, /http:\/\/[^ \t\n]+/)),
    https_url: $ => token(prec(3, /https:\/\/[^ \t\n]+/)),
    ftp_url:   $ => token(prec(3, /ftp:\/\/[^ \t\n]+/)),

    // Fallback for other schemes (rsync://, file://, ...).
    generic_url: $ => token(prec(1, /[a-z][a-z0-9+.-]*:\/\/[^ \t\n]+/i)),
  },
});
