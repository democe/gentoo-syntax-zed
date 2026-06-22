; inherits: bash
;
; Gentoo /etc/init.d/ scripts — OpenRC-specific helpers layered on bash.
; Mirrors gentoo-syntax/syntax/gentoo-init-d.vim.

[
  (expansion)
  (simple_expansion)
] @variable.special

; depend() keywords: config need use before after provide keyword
((command name: (command_name) @keyword
  (#any-of? @keyword
    "config" "need" "use" "before" "after" "provide" "keyword")))

; OpenRC messaging & helpers
((command name: (command_name) @function
  (#any-of? @function
    "ebegin" "vebegin" "eend" "veend" "ewend" "vewend"
    "einfo" "veinfo" "ewarn" "vewarn" "eerror" "veerror"
    "ewaitfile" "is_newer_than" "is_older_than"
    "service_set_value" "service_get_value"
    "service_started" "service_starting" "service_inactive"
    "service_stopping" "service_stopped" "service_coldplugged"
    "service_wasinactive" "service_started_daemon"
    "mark_service_started" "mark_service_starting"
    "mark_service_inactive" "mark_service_stopping"
    "mark_service_stopped" "mark_service_coldplugged"
    "mark_service_wasinactive" "checkpath" "yesno")))

; Standard init.d phase functions
(function_definition name: (word) @function
  (#any-of? @function
    "describe" "start_pre" "start" "start_post" "stop_pre" "stop" "stop_post"
    "reload" "restart" "status" "zap" "depend"))

; Special OpenRC variables
((variable_assignment name: (variable_name) @constant
  (#any-of? @constant
    "extra_commands" "extra_started_commands" "extra_stopped_commands"
    "description" "command" "command_args" "command_background" "pidfile" "name"
    "start_stop_daemon_args" "retry" "required_dirs" "required_files"
    "RC_SVCNAME" "RC_RUNLEVEL" "RC_REBOOT" "RC_BOOTLEVEL"
    "RC_DEFAULTLEVEL" "RC_SYS" "RC_PREFIX" "RC_UNAME" "RC_CMD")))

; Deprecated `opts`
((variable_assignment name: (variable_name) @keyword
  (#eq? @keyword "opts")))
