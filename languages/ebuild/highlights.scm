; inherits: bash
;
; Gentoo ebuild/eclass highlights layered on top of the bash grammar.
; Mirrors gentoo-syntax/syntax/ebuild.vim.
;
; Capture mapping (vim group -> nvim capture):
;   EbuildCoreKeyword        -> @keyword
;   EbuildFunctions          -> @function
;   EbuildInherit            -> @keyword
;   Ebuild*Keyword (eclass)  -> @function
;   EbuildDeprecatedKeyword  -> @keyword / @hint
;   EbuildExportFunctions    -> @constant
;   EclassDocumentationTag   -> @keyword
;   EbuildError*             -> @hint
;
; `#any-of?` matches the literal text of a node against a list, which is
; exactly what the old `syn keyword` rules were doing.

; --- Core ebuild helpers ---------------------------------------------------
((command name: (command_name) @keyword
  (#any-of? @keyword
    "use" "has_version" "best_version" "use_with" "use_enable"
    "keepdir" "econf" "die" "einstall" "einfo" "ewarn" "eqawarn" "eerror" "diropts"
    "dobin" "docinto" "dodoc" "doexe" "doheader" "doinfo" "doins"
    "dolib" "dolib.a" "dolib.so" "doman" "dosbin" "dosym" "emake" "exeinto"
    "exeopts" "fowners" "fperms" "insinto" "insopts" "into" "libopts" "newbin"
    "newexe" "newheader" "newins" "newman" "newsbin" "has" "unpack" "into"
    "doinitd" "doconfd" "doenvd" "domo" "dodir" "ebegin" "eend"
    "newconfd" "newdoc" "newenvd" "newinitd" "newlib.a" "newlib.so"
    "hasv" "usev" "usex" "elog" "eapply" "eapply_user"
    "einstalldocs" "in_iuse" "get_libdir"
    "dostrip" "ver_cut" "ver_rs" "ver_test"
    "addread" "addwrite" "adddeny" "addpredict")))

; --- Recognised ebuild phase functions -------------------------------------
((command name: (command_name) @function
  (#any-of? @function
    "pkg_pretend" "pkg_nofetch" "pkg_setup" "src_unpack" "src_compile" "src_test" "src_install"
    "pkg_preinst" "pkg_postinst" "pkg_prerm" "pkg_postrm" "pkg_config"
    "pkg_info" "src_prepare" "src_configure"
    "default" "default_pkg_nofetch" "default_src_unpack" "default_src_prepare"
    "default_src_configure" "default_src_compile" "default_src_test"
    "default_src_install")))

; Also highlight these when they appear as function_definition names.
(function_definition name: (word) @function
  (#any-of? @function
    "pkg_pretend" "pkg_nofetch" "pkg_setup" "src_unpack" "src_compile" "src_test" "src_install"
    "pkg_preinst" "pkg_postinst" "pkg_prerm" "pkg_postrm" "pkg_config"
    "pkg_info" "src_prepare" "src_configure"))

; --- inherit ---------------------------------------------------------------
((command name: (command_name) @keyword
  (#eq? @keyword "inherit")))

; --- Eclass helper functions (Identifier) ----------------------------------
((command name: (command_name) @function
  (#any-of? @function
    ; autotools
    "eautoreconf" "eaclocal" "_elibtoolize" "eautoconf" "eautoheader" "eautomake"
    ; eutils
    "draw_line" "epatch" "have_NPTL" "get_number_of_jobs"
    "emktemp" "edos2unix" "make_desktop_entry" "strip-linguas"
    "make_session_desktop" "domenu" "doicon" "newicon"
    "preserve_old_lib" "preserve_old_lib_notify" "epunt_cxx"
    "make_wrapper"
    ; flag-o-matic
    "setup-allowed-flags" "filter-flags" "filter-lfs-flags" "append-lfs-flags"
    "append-flags" "replace-flags" "replace-cpu-flags" "is-flag" "filter-mfpmath"
    "strip-flags" "test-flag" "test_version_info" "strip-unsupported-flags" "get-flag"
    "replace-sparc64-flags" "append-ldflags" "filter-ldflags"
    "append-cflags" "append-cppflags" "append-cxxflags" "append-fflags"
    "is-flagq" "is-ldflagq" "is-ldflag" "test-flag-CC" "test-flag-CXX"
    "test-flag-F77" "test-flag-FC" "test-flags-CC" "test-flags-CXX"
    "test-flags-F77" "test-flags-FC" "test-flags" "append-libs"
    "raw-ldflags" "no-as-needed"
    ; libtool
    "elibtoolize" "uclibctoolize" "darwintoolize"
    ; fixheadtails
    "ht_fix_file" "ht_fix_all"
    ; fdo-mime
    "fdo-mime_desktop_database_update" "fdo-mime_mime_database_update"
    ; webapp
    "webapp_checkfileexists" "webapp_import_config" "webapp_strip_appdir"
    "webapp_strip_d" "webapp_strip_cwd" "webapp_configfile" "webapp_hook_script"
    "webapp_postinst_txt" "webapp_postupgrade_txt" "webapp_runbycgibin"
    "webapp_serverowned" "webapp_server_configfile" "webapp_sqlscript"
    "webapp_src_install" "webapp_pkg_postinst" "webapp_pkg_setup"
    "webapp_getinstalltype" "webapp_src_preinst" "webapp_pkg_prerm"
    ; versionator
    "get_all_version_components" "version_is_at_least"
    "get_version_components" "get_major_version"
    "get_version_component_range" "get_after_major_version"
    "replace_version_separator" "replace_all_version_separators"
    "delete_version_separator" "delete_all_version_separators"
    ; cvs
    "cvs_fetch" "cvs_src_unpack"
    ; bash-completion-r1
    "dobashcomp" "newbashcomp" "get_bashcompdir"
    "get_bashhelpersdir" "bashcomp_alias"
    ; vim-plugin
    "vim-plugin_src_install" "vim-plugin_pkg_postinst" "vim-plugin_pkg_postrm"
    "update_vim_afterscripts" "display_vim_plugin_help"
    ; vim-doc
    "update_vim_helptags"
    ; multilib
    "has_multilib_profile" "get_multilibdir" "get_libdir_override"
    "get_abi_var" "get_abi_CFLAGS" "get_abi_LDFLAGS" "get_abi_CHOST"
    "get_abi_FAKE_TARGETS" "get_abi_CDEFINE" "get_abi_LIBDIR" "get_install_abis"
    "get_all_abis" "get_all_libdirs" "is_final_abi" "number_abis" "get_ml_incdir"
    "prep_ml_includes" "create_ml_includes" "create_ml_includes-absolute"
    "create_ml_includes-tidy_path" "create_ml_includes-listdirs"
    "create_ml_includes-makedestdirs" "create_ml_includes-allfiles"
    "create_ml_includes-sym_for_dir"
    ; toolchain-funcs
    "tc-getPROG" "tc-getAR" "tc-getAS" "tc-getCC" "tc-getCXX" "tc-getLD" "tc-getNM"
    "tc-getRANLIB" "tc-getF77" "tc-getGCJ" "tc-getBUILD_CC" "tc-export" "ninj"
    "tc-is-cross-compiler" "tc-ninja_magic_to_arch" "tc-arch-kernel" "tc-arch"
    "tc-endian" "gcc-fullversion" "gcc-version" "gcc-major-version"
    "gcc-minor-version" "gcc-micro-version" "gen_usr_ldscript"
    ; cron
    "docrondir" "docron" "docrontab" "cron_pkg_postinst"
    ; subversion
    "subversion_fetch" "subversion_bootstrap" "subversion_src_unpack"
    ; alternatives
    "alternatives_auto_makesym" "alternatives_makesym" "alternatives_pkg_postinst"
    "alternatives_pkg_postrm"
    ; rpm
    "rpm_unpack" "rpm_src_unpack"
    ; python-utils-r1
    "python_export" "python_get_sitedir" "python_get_includedir"
    "python_get_library_path" "python_get_CFLAGS" "python_get_LIBS"
    "python_get_PYTHON_CONFIG" "python_get_scriptdir"
    "python_optimize" "python_scriptinto" "python_doexe"
    "python_newexe" "python_doscript" "python_newscript"
    "python_moduleinto" "python_domodule" "python_doheader"
    "python_wrapper_setup" "python_is_python3" "python_is_installed"
    "python_fix_shebang" "python_export_utf8_locale" "build_sphinx"
    "epytest" "eunittest"
    ; python-r1 / python-single-r1 / python-any-r1
    "python_gen_usedep" "python_gen_useflags" "python_gen_cond_dep"
    "python_gen_impl_dep" "python_copy_sources" "python_foreach_impl"
    "python_setup" "python_replicate_script" "python_gen_any_dep"
    "python-single-r1_pkg_setup" "python-any-r1_pkg_setup"
    "python_check_deps"
    ; perl-module
    "perl-module_src_prep" "perl-module_src_compile" "perl-module_src_test"
    "perl-module_src_install" "perl-module_pkg_setup" "perl-module_pkg_preinst"
    "perl-module_pkg_postinst" "perl-module_pkg_prerm" "perl-module_pkg_postrm"
    "perlinfo" "fixlocalpod" "updatepod"
    ; distutils-r1
    "distutils_install_for_testing"
    "distutils-r1_python_prepare_all"
    "distutils-r1_python_compile"
    "distutils-r1_python_install"
    "distutils-r1_python_install_all"
    "sphinx_compile_all"
    "distutils_enable_tests"
    "distutils_enable_sphinx"
    ; distutils-r1 sub-phases
    "python_prepare" "python_prepare_all"
    "python_configure" "python_configure_all"
    "python_compile" "python_compile_all"
    "python_test" "python_test_all"
    "python_install" "python_install_all"
    ; depend.apache
    "need_apache" "need_apache1" "need_apache2"
    ; apache-module
    "apache-module_pkg_setup" "apache-module_src_compile"
    "apache-module_src_install" "apache-module_pkg_postinst" "acache_cd_dir"
    "apache_mod_file" "apache_doc_magic" "apache1_src_compile" "apache1_src_install"
    "apache1_pkg_postinst" "apache2_pkg_setup" "apache2_src_compile"
    "apache1_src_install" "apache2_pkg_postinst"
    ; pam
    "dopamd" "newpamd" "dopamsecurity" "newpamsecurity" "getpam_mod_dir"
    "dopammod" "newpammod" "pamd_mimic_system"
    ; virtualx
    "virtualmake" "Xmake" "Xemake" "Xeconf"
    ; gnome2
    "gnome2_src_configure" "gnome2_src_compile" "gnome2_src_install"
    "gnome2_gconf_install" "gnome2_gconf_uninstal" "gnome2_omf_fix"
    "gnome2_scrollkeeper_update" "gnome2_pkg_postinst" "gnome2_pkg_postrm"
    ; cdrom
    "cdrom_get_cds" "cdrom_load_next"
    ; linux-info
    "set_arch_to_kernel" "set_arch_to_portage"
    ; unpacker
    "unpack_pdv" "unpack_makeself"
    ; user
    "egetent"
    ; cmake
    "cmake_run_in" "cmake_comment_add_subdirectory" "cmake_use_find_package"
    "cmake_build" "mycmakeargs" "MYCMAKEARGS"
    "cmake_src_prepare" "cmake_src_configure" "cmake_src_compile"
    "cmake_src_test" "cmake_src_install"
    ; tmpfiles
    "dotmpfiles" "newtmpfiles" "tmpfiles_process"
    ; udev
    "get_udevdir" "udev_dorules" "udev_newrules" "udev_reload"
    ; check-reqs
    "check-reqs_pkg_setup" "check-reqs_pkg_pretend")))

; --- Deprecated / banned functions (Error) ---------------------------------
((command name: (command_name) @keyword
  (#any-of? @keyword
    "check_KV" "dohard" "dohtml" "prepall" "prepalldocs"
    "prepallinfo" "prepallman" "prepallstrip" "dosed"
    "dojar" "hasq" "useq"
    "draw_line" "have_NPTL" "get_number_of_jobs" "check_license"
    "ebeep" "epause" "built_with_use"
    "dobashcompletion" "bash-completion_pkg_postinst"
    "egamesconf" "egamesinstall" "gameswrapper" "dogamesbin" "dogamessbin" "dogameslib"
    "dogameslib.a" "dogameslib.so" "newgamesbin" "newgamessbin" "gamesowners" "gamesperms"
    "prepgamesdirs" "gamesenv" "games_pkg_setup" "games_src_compile" "games_pkg_postinst"
    "games_ut_unpack" "games_umod_unpack" "games_make_wrapper"
    "python_pkg_setup" "python_convert_shebangs" "python_clean_installation_image"
    "python_src_prepare" "python_src_configure" "python_src_compile" "python_src_test"
    "python_src_install" "python_execute_function"
    "python_generate_wrapper_scripts" "python_set_active_version" "python_need_rebuild"
    "PYTHON" "python_get_implementation" "python_get_implementational_package"
    "python_get_libdir" "python_get_library"
    "python_get_version" "python_execute_nosetests" "python_execute_py.test"
    "python_execute_trial" "python_enable_pyc" "python_disable_pyc" "python_mod_optimize"
    "python_mod_cleanup"
    "python_parallel_foreach_impl" "python_export_best"
    "distutils_src_unpack" "distutils_src_prepare" "distutils_src_compile"
    "distutils_src_test" "distutils_src_install" "distutils_pkg_postinst"
    "distutils_pkg_postrm"
    "enewuser" "enewgroup"
    "udev_get_udevdir"
    "esleep"
    "prepalldocs")))

; --- EXPORT_FUNCTIONS ------------------------------------------------------
; `EXPORT_FUNCTIONS name1 name2 ...` — highlight the keyword and the names.
((command name: (command_name) @constant
  (#eq? @constant "EXPORT_FUNCTIONS"))
  (command argument: (word) @function))

; --- Shell expansions ------------------------------------------------------
; Make variable references stand out from surrounding string content.
[
  (expansion)
  (simple_expansion)
] @variable.special

; --- Eclass documentation tags in comments ---------------------------------
; Comments containing @TAG or @TAG: at end-of-line get a doc-tag capture.
((comment) @comment
  (#lua-match? @comment "@\\(DEAD\\|DEFAULT_UNSET\\|INCLUDES_EPREFIX\\|INTERNAL\\|OUTPUT_VARIABLE\\|PRE_INHERIT\\|REQUIRED\\|USER_VARIABLE\\)$"))

; --- Common ebuild mistakes flagged as errors ------------------------------
; `LICENCE` (misspelling of LICENSE)
((variable_assignment name: (variable_name) @hint
  (#eq? @hint "LICENCE")))

; read-only variables P, PN, PV, PR, PVR, PF, A
((variable_assignment name: (variable_name) @hint
  (#any-of? @hint "P" "PN" "PV" "PR" "PVR" "PF" "A")))

; SLOT="" / SLOT='' / unset SLOT
((variable_assignment
  name: (variable_name) @hint
  value: (string) @hint
  (#eq? @hint "SLOT")
  (#lua-match? @hint "^\"\"$"))
  (#set! "priority" 105))

; HOMEPAGE containing variable references (should be a literal URL)
((variable_assignment
  name: (variable_name) @hint
  (#eq? @hint "HOMEPAGE")
  value: (string
    (expansion) @hint)))

; ${PN}-${PV} instead of ${P} — match the whole string value.
; (Simplified from the vim regex; flags only the literal sequence.)
((variable_assignment
  name: (variable_name) @variable
  value: (string) @string
  (#lua-match? @string "^\".*\\$\\{PN\\}-\\$\\{PV\\}.*\"$")))

; EXTRA_ECONF inside strings
((expansion
  (variable_name) @hint
  (#eq? @hint "EXTRA_ECONF")))

; --- Banned vim-style `which` calls ----------------------------------------
((command_substitution
  (command name: (command_name) @hint
    (#eq? @hint "which"))))
