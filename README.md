# Gentoo Syntax for Zed

Tree-sitter powered Gentoo syntax highlighting for Zed, based on
[gentoo-syntax-nvim](https://github.com/democe/gentoo-syntax-nvim).

This extension includes language configs and queries for:

- `*.ebuild` and `*.eclass`
- OpenRC init scripts with `#!/sbin/runscript` or `#!/sbin/openrc-run`
- `make.conf`, `make.globals`
- `package.use`, `package.env`, `package.keywords`,
  `package.accept_keywords`, `package.license`, `package.mask`,
  `package.unmask`, and `package.properties`
- `use.desc`, `use.local.desc`
- `thirdpartymirrors`, `mirrors`
- `metadata.xml`, GuideXML, and GLEPs

## Local Development

Install this repository as a dev extension from Zed:

1. Open the Extensions page.
2. Run `zed: install dev extension`.
3. Select this repository directory.

The custom Gentoo grammars live in this repository under `grammars/`.
`extension.toml` references this repository once per grammar and uses each
grammar's `path` field so Zed can compile the correct parser.

Before publishing through `zed-industries/extensions`, replace the temporary
`rev = "main"` values for the custom Gentoo grammars with a pinned commit SHA.
The upstream Bash, XML, and RST grammars are already pinned.

Zed language configs support suffix and first-line detection. They do not
cover every path-pattern rule from `gentoo-syntax-nvim`, such as
`/etc/conf.d/*` or `/etc/portage/package.use/*`. Those files can still be
selected manually with Zed's language selector or mapped in user settings.

## Publishing

Zed extension publishing is done through the
[zed-industries/extensions](https://github.com/zed-industries/extensions)
registry. In your fork, add this repository as a submodule under
`extensions/gentoo-syntax`, add the matching `[gentoo-syntax]` entry to
`extensions.toml`, and run `pnpm sort-extensions`.

## License

MIT. See [LICENSE](LICENSE).
