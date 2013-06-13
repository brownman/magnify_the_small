#!/usr/bin/env bash
# Completion for timer

_installcomp() {
  if [ -z "$REMOTE_timerS" ]
  then
    REMOTE_timerS=( $(timer list --remote --no-versions | tr '\n' ' ') )
  fi
  
  local cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "${REMOTE_timerS[*]}" -- $cur) )
}

_uninstallcomp() {
  if [ -z "$LOCAL_timerS" ]
  then
    LOCAL_timerS=( $(timer list --no-versions | sed 's/\*\*\* LOCAL timerS \*\*\*//' | tr '\n' ' ') )
  fi
  
  local cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "${LOCAL_timerS[*]}" -- $cur) )
}

_timer() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  local prev=${COMP_WORDS[COMP_CWORD-1]}
  case $prev in
    install)
      _installcomp
      return 0
      ;;
    uninstall)
      _uninstallcomp
      return 0
      ;;
  esac
  local commands=(build cert check cleanup contents dependency environment fetch generate_index help install list lock outdated owner pristine push query rdoc search server sources specification stale uninstall unpack update which)
  COMPREPLY=( $(compgen -W "${commands[*]}" -- $cur) )
}

complete -F _timer timer
