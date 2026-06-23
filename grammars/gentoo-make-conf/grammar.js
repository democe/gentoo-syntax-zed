/**
 * gentoo-make-conf — tree-sitter grammar for Portage make.conf files.
 *
 * make.conf is a line-oriented shell-like config: lines are either comments
 * (`#...`), blank, or `KEY=value` assignments. Values may be bareword tokens
 * or double-quoted strings. A handful of well-known variables receive
 * dedicated substructure (USE flags, ACCEPT_KEYWORDS arches, FEATURES, …)
 * mirroring the old vim syntax file.
 *
 * Reference: gentoo-syntax/syntax/gentoo-make-conf.vim
 */

const ARCHES = [
  'alpha', 'amd64', 'amd64-fbsd', 'amd64-linux',
  'arm', 'arm64', 'arm64-linux', 'arm-linux',
  'hppa', 'ia64', 'loong',
  'm68k', 'm68k-mint', 'mips',
  'ppc', 'ppc64', 'ppc64-linux', 'ppc-aix', 'ppc-macos',
  'riscv', 's390', 'sh',
  'sparc', 'sparc64-solaris', 'sparc-solaris',
  'x64-cygwin', 'x64-macos', 'x64-solaris',
  'x86', 'x86-cygwin', 'x86-fbsd', 'x86-linux', 'x86-macos', 'x86-solaris', 'x86-winnt',
];

// Known variable names (GentooMakeConfEMISCK -> Identifier).
const KNOWN_VARS = [
  'GENTOO_MIRRORS', 'SYNC', 'PORTAGE_NICENESS', 'PORTDIR_OVERLAY',
  'PORTAGE_GPG_DIR', 'PORTAGE_GPG_KEY', 'SIGNED_OFF_BY',
  'CONFIG_PROTECT_MASK', 'CONFIG_PROTECT',
  'FETCHCOMMAND', 'RESUMECOMMAND', 'AUTOCLEAN', 'BUILD_PREFIX', 'CBUILD',
  'CLEAN_DELAY', 'COLLISION_IGNORE', 'DISTDIR', 'DOC_SYMLINKS_DIR',
  'EMERGE_DEFAULT_OPTS', 'HTTP_PROXY', 'FTP_PROXY', 'NOCOLOR', 'PKGDIR',
  'PORT_LOGDIR', 'PORT_LOGDIR_CLEAN', 'PORTAGE_BINHOST',
  'PORTAGE_BINHOST_HEADER_URI', 'PORTAGE_BINPKG_FORMAT',
  'PORTAGE_BINPKG_TAR_OPTS', 'PORTAGE_COMPRESS', 'PORTAGE_COMPRESS_FLAGS',
  'PORTAGE_ELOG_CLASSES', 'PORTAGE_ELOG_COMMAND',
  'PORTAGE_ELOG_MAILFROM', 'PORTAGE_ELOG_MAILURI', 'PORTAGE_ELOG_SYSTEM',
  'PORTAGE_FETCH_CHECKSUM_TRY_MIRRORS', 'PORTAGE_FETCH_RESUME_MIN_SIZE',
  'PORTAGE_LOGDIR', 'PORTAGE_LOGDIR_CLEAN', 'PORTAGE_RSYNC_EXTRA_OPTS',
  'PORTAGE_RSYNC_OPTS', 'PORTAGE_RSYNC_INITIAL_TIMEOUT',
  'PORTAGE_RSYNC_RETRIES', 'PORTAGE_TMPDIR', 'PORTAGE_WORKDIR_MODE',
  'PORTDIR', 'ROOT', 'RSYNC_EXCLUDEFROM', 'RSYNC_RETRIES',
  'RSYNC_TIMEOUT', 'RPMDIR', 'USE_ORDER', 'LINGUAS', 'EXTRA_ECONF',
  'PORTAGE_TMPFS', 'INSTALL_MASK', 'QA_STRICT_EXECSTACK',
  'QA_STRICT_WX_LOAD', 'QA_STRICT_TEXTRELS', 'PORTAGE_IONICE_COMMAND',
  'PORTAGE_LOG_FILTER_FILE_CMD', 'PORTAGE_SCHEDULING_POLICY',
  'BINPKG_COMPRESS', 'BINPKG_COMPRESS_FLAGS',
];

// Eclass-flavoured known variables (GentooMakeConfEMISCKE -> Special).
const ECLASS_VARS = [
  'EBEEP_IGNORE', 'EPAUSE_IGNORE', 'CHECKREQS_DONOTHING',
  'BREAKME', 'ECHANGELOG_USER', 'CCACHE_SIZE', 'CCACHE_DIR',
  'CCACHE_SLOPPINESS', 'DISTCC_DIR',
];

// Read-only variables that must never be set in make.conf
// (GentooMakeConfEMISCN -> Error). LDFLAGS has its own dedicated rule.
const NAUGHTY_VARS = [
  'ASFLAGS', 'ARCH', 'ELIBC', 'KERNEL', 'USERLAND',
];

module.exports = grammar({
  name: 'gentoo_make_conf',
  // No extras: whitespace is significant inside quoted strings and is
  // handled explicitly by the value rules below.
  extras: $ => [],

  rules: {
    file: $ => repeat(choice($.comment, $.blank_line, $.assignment)),

    blank_line: $ => /[ \t]*\n/,

    comment: $ => token(seq('#', /[^\n]*/)),

    assignment: $ => seq(
      $.variable_name,
      '=',
      optional($.value),
      optional('\n'),
    ),

    variable_name: $ => choice(
      $.use_keyword,
      $.accept_keywords,
      $.accept_license,
      $.accept_properties,
      $.allow_test,
      $.cflags_name,
      $.ldflags_name,
      $.makeopts_name,
      $.chost_name,
      $.features_name,
      $.known_variable,
      $.eclass_variable,
      $.naughty_variable,
      $.misc_variable,
    ),

    // --- Specialised keywords (prec(2) beats naughty/misc) --------------
    use_keyword:       $ => prec(2, 'USE'),
    accept_keywords:   $ => prec(2, 'ACCEPT_KEYWORDS'),
    accept_license:    $ => prec(2, 'ACCEPT_LICENSE'),
    accept_properties: $ => prec(2, 'ACCEPT_PROPERTIES'),
    allow_test:        $ => prec(2, 'ALLOW_TEST'),
    cflags_name:       $ => prec(2, choice('CFLAGS', 'CXXFLAGS', 'FFLAGS', 'FCFLAGS')),
    ldflags_name:      $ => prec(2, 'LDFLAGS'),
    makeopts_name:     $ => prec(2, 'MAKEOPTS'),
    chost_name:        $ => prec(2, 'CHOST'),
    features_name:     $ => prec(2, 'FEATURES'),
    known_variable:    $ => prec(2, choice(...KNOWN_VARS)),
    eclass_variable:   $ => prec(2, choice(...ECLASS_VARS)),
    naughty_variable:  $ => prec(1, choice(...NAUGHTY_VARS)),
    misc_variable:     $ => /[A-Za-z0-9_-]+/,

    // --- Values ----------------------------------------------------------
    value: $ => choice($.quoted_string, $.bareword_list),

    quoted_string: $ => seq(
      '"',
      repeat(choice(
        $.ws,
        $.escape,
        $.var_ref,
        $.use_flag,
        $.arch,
        $.license_token,
        $.feature,
        $.flag_token,
        $.bad_sparc_chost,
        $.makeopts_bad_j,
        $.string_chunk,
      )),
      '"',
    ),

    // Whitespace inside a quoted value (kept in the tree so spans stay
    // accurate; queries ignore it).
    ws: $ => /[ \t]+/,

    // Raw text inside a quoted string (no extras, so spaces are kept).
    string_chunk: $ => token.immediate(prec(-1, /[^"\\$ \t\n]+/)),

    bareword_list: $ => repeat1(seq(
      choice(
        $.escape,
        $.var_ref,
        $.use_flag,
        $.arch,
        $.license_token,
        $.feature,
        $.flag_token,
        $.bad_sparc_chost,
        $.makeopts_bad_j,
        $.bareword_chunk,
      ),
      optional(/[ \t]+/),
    )),

    bareword_chunk: $ => token.immediate(prec(-1, /[^\n \t"\\$]+/)),

    escape:  $ => token.immediate(choice(/\\./, /\\\n/)),
    var_ref: $ => token.immediate(choice(
      /\$\{[^}]+\}/,
      /\$[A-Za-z0-9_-]+/,
    )),

    // USE flag: +flag, -flag, @set, -*, plain flag.
    use_flag: $ => token.immediate(prec(1, choice(
      /-?[A-Za-z0-9_:-]+/,
      /-?@[A-Za-z0-9_-]+/,
      /-\*/,
    ))),

    // ACCEPT_KEYWORDS arch (~arch / arch / -arch).
    arch: $ => token.immediate(prec(1, choice(
      seq('~', choice(...ARCHES)),
      ...ARCHES,
      /-[A-Za-z0-9_-]+/,
    ))),

    // ACCEPT_LICENSE tokens: * name @group -name -@group -*.
    license_token: $ => token.immediate(prec(1, choice(
      '@[A-Za-z0-9_.+-]+',
      '-@?[A-Za-z0-9_.+-]+',
      /\*/,
      /[A-Za-z0-9_.+-]+/,
    ))),

    // ACCEPT_PROPERTIES / ALLOW_TEST / FEATURES tokens.
    feature: $ => token.immediate(prec(1, choice(
      /-?[A-Za-z0-9_-]+/,
      /\*/,
      /\+[A-Za-z0-9_-]+/,
    ))),

    // Generic flag token for CFLAGS/LDFLAGS (a dash-prefixed word).
    flag_token: $ => token.immediate(prec(1, /-[A-Za-z0-9_+=.,:/-]+/)),

    // Bad `-j N` (with space) in MAKEOPTS.
    makeopts_bad_j: $ => token.immediate(prec(2, seq('-j', /[ \t]+/, /[0-9]+/))),

    // A CHOST that starts with "sparc" but is not "sparc-unknown-linux-gnu".
    bad_sparc_chost: $ => token.immediate(prec(1, /sparc(-unknown-linux-gnu)?[^\n \t]*/)),
  },
});
