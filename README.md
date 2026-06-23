# Gentoo Syntax

Gentoo Portage and OpenRC syntax highlighting for
[Zed](https://zed.dev), based on
[gentoo-syntax-nvim](https://github.com/democe/gentoo-syntax-nvim).

## Languages

- Ebuild and eclass files
- OpenRC init scripts
- `make.conf` and `make.globals`
- `package.use`, `package.env`, `package.keywords`,
  `package.accept_keywords`, `package.license`, `package.mask`,
  `package.unmask`, and `package.properties`
- `use.desc` and `use.local.desc`
- `thirdpartymirrors` and `mirrors`
- `metadata.xml`, GuideXML, and GLEPs

The extension ships custom Tree-sitter grammars for Gentoo's line-oriented
Portage formats and reuses Bash, XML, and reStructuredText grammars for the
remaining file types.

## Status

This extension currently provides syntax highlighting and basic language
metadata. It does not include language servers, snippets, scaffolding commands,
or the full path-pattern detection from `gentoo-syntax-nvim`; files that Zed
cannot infer from suffix or first line can still be selected manually or mapped
in user settings.

## License

MIT. See [LICENSE](LICENSE).
