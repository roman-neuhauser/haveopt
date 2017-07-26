#!/bin/sh
# vim: ft=sh ts=2 sts=2 sw=2 et fdm=marker cms=\ #\ %s

if [ "x${0##*/}" = xhaveopt.sh ]; then
  if [ -z "$ZSH_EVAL_CONTEXT" ] || [ "$ZSH_EVAL_CONTEXT" = toplevel ]; then
    echo >&2 "$0 is meant to be sourced, not executed"
    exit 2
  fi
fi

haveopt()
{
  if [ "x${ZSH_VERSION+set}" = xset ]; then
    # zsh is normally too different from posixish shells
    # `local_options` limits the effect of the `emulate`
    # command to the surrounding function (ie, haveopt).
    emulate -R sh
    setopt local_options
  fi

  # configuration {{{
  local haveopt_usage='usage: haveopt IND OPT ARG [OPTSPEC...] -- "$@"\n'

  if [ $# -eq 1 ]; then
    case $1 in
      -h|--help) printf "$haveopt_usage" ;;
    esac
    return 0
  fi
  if [ $# -le 3 ]; then
    printf >&2 "$haveopt_usage"
    return 2
  fi
  if [ $# -eq 4 ] && [ "x$4" != x-- ]; then
    printf >&2 "$haveopt_usage"
    return 2
  fi
  
  # name of the cookie used to store
  # the iterator over bundled short options
  local haveopt_cookie="HAVEOPT_shopt_iter__$(
    printf "%s\0" "$@" | cksum | tr ' ' _
  )"

  local haveopt_name
  for haveopt_name in "$1" "$2" "$3"; do
    case $haveopt_name in
    # posh does not implement [:class:] syntax yet
    [!_a-zA-Z]*     |\
    *[!_a-zA-Z0-9]* )
      printf >&2 "haveopt: invalid identifier: %s\n" "$haveopt_name"
      return 2
    ;;
    esac
  done
  local haveopt_ip="$1" haveopt_np="$2" haveopt_ap="$3"
  shift 3

  local haveopt_sopts= haveopt_lopts=
  local haveopt_argv_sep_seen=0

  while [ $# -gt 0 ]; do
    case "$1" in
    --)
      haveopt_argv_sep_seen=1
      # remove the '--' optspeclist terminator
      # leaving the actual args in $@
      shift
      break
    ;;
    ?=|?)
      haveopt_sopts="$haveopt_sopts $1"
    ;;
    *)
      haveopt_lopts="$haveopt_lopts $1"
    ;;
    esac
    shift
  done

  if [ $haveopt_argv_sep_seen -eq 0 ]; then
    printf >&2 "$haveopt_usage"
    return 2
  fi
  # }}}

  # one shot {{{
  local haveopt_optind
  eval "haveopt_optind=\"\$$haveopt_ip\""
  haveopt_optind=$(expr "$haveopt_optind" : '\([0-9]*\)' \| 0)

  # remove already-processed arguments
  # so that we always work with $1
  shift $haveopt_optind

  local haveopt_arg="${1-}"
  local haveopt_opt
  local haveopt_optarg
  local haveopt_optname
  local haveopt_needs_optarg=0

  case $haveopt_arg in
  --)
    haveopt_optind=$(( haveopt_optind + 1 ))
  ;;
  --?*)
    # long option {{{
    for haveopt_opt in $haveopt_lopts; do
      haveopt_optname=${haveopt_opt%=}
      haveopt_needs_optarg=0
      case "$haveopt_opt" in
      *=) haveopt_needs_optarg=1 ;;
      esac
      case "$haveopt_arg" in
      --$haveopt_optname=*)
        haveopt_optind=$(( haveopt_optind + 1 ))
        haveopt_optarg="${haveopt_arg#--$haveopt_optname=}"
        eval "$haveopt_np=\"\$haveopt_optname\""
        eval "$haveopt_ap=\"\$haveopt_optarg\""
        eval "$haveopt_ip=\$haveopt_optind"
        return 0
      ;;
      --$haveopt_optname)
        if [ $haveopt_needs_optarg -ne 0 ]; then
          if [ $# -gt 1 ]; then
            haveopt_optind=$(( haveopt_optind + 2 ))
            haveopt_optarg="$2"
            eval "$haveopt_ap=\"\$2\""
          else
            haveopt_optind=$(( haveopt_optind + 1 ))
            haveopt_optarg="$haveopt_optname"
            haveopt_optname=:
            eval "$haveopt_ap=\"\$haveopt_optarg\""
          fi
        else
          haveopt_optind=$(( haveopt_optind + 1 ))
          eval "unset $haveopt_ap"
        fi
        eval "$haveopt_ip=\$haveopt_optind"
        eval "$haveopt_np=\"\$haveopt_optname\""
        return 0
      ;;
      esac
    done
    haveopt_optind=$(( haveopt_optind + 1 ))
    haveopt_optname="${haveopt_arg#--}"
    haveopt_optname="${haveopt_optname%%=*}"
    eval "$haveopt_ip=\$haveopt_optind"
    eval "$haveopt_np=?"
    eval "$haveopt_ap=\"\$haveopt_optname\""
    return
    # }}}
  ;;
  -?)
    # short option {{{
    for haveopt_opt in $haveopt_sopts; do
      haveopt_optname=${haveopt_opt%=}
      haveopt_needs_optarg=0
      case "$haveopt_opt" in
      *=) haveopt_needs_optarg=1 ;;
      esac
      case "$haveopt_arg" in
      -$haveopt_optname)
        # i'm torn: brevity or side-by-side view?
        if [ $haveopt_needs_optarg -ne 0 ]; then
          if [ $# -gt 1 ]; then
            haveopt_optind=$(( haveopt_optind + 2 ))
            haveopt_optarg="$2"
            eval "$haveopt_ap=\"\$2\""
          else
            haveopt_optind=$(( haveopt_optind + 1 ))
            haveopt_optarg="$haveopt_optname"
            haveopt_optname=:
            eval "$haveopt_ap=\"\$haveopt_optarg\""
          fi
        else
          haveopt_optind=$(( haveopt_optind + 1 ))
          eval "unset $haveopt_ap"
        fi
        eval "$haveopt_ip=\$haveopt_optind"
        eval "$haveopt_np=\"\$haveopt_optname\""
        # no cookie
        return 0
      ;;
      esac
    done
    haveopt_optind=$(( haveopt_optind + 1 ))
    haveopt_optname="${haveopt_arg#-}"
    eval "$haveopt_ip=\$haveopt_optind"
    eval "$haveopt_np=?"
    eval "$haveopt_ap=\"\$haveopt_optname\""
    return
    # }}}
  ;;
  -??*)
    # bundle of short options {{{
    local haveopt_bit
    eval "haveopt_bit=\"\${$haveopt_cookie:-0}\""

    # remove already-scanned characters on the left {{{
    haveopt_arg="-${haveopt_arg#-$(
      [ $haveopt_bit -eq 0 ] || printf "%${haveopt_bit}s" '' | tr ' ' '?'
    )}"
    # }}}

    # is the current character a known option? {{{
    for haveopt_opt in $haveopt_sopts; do
      haveopt_optname=${haveopt_opt%=}
      haveopt_needs_optarg=0
      case "$haveopt_opt" in
      *=) haveopt_needs_optarg=1 ;;
      esac
      case "$haveopt_arg" in
      -$haveopt_optname)
        # last option in the bundle
        haveopt_bit=0
        if [ $haveopt_needs_optarg -ne 0 ]; then
          if [ $# -gt 1 ]; then
            haveopt_optind=$(( haveopt_optind + 2 ))
            haveopt_optarg="$2"
            eval "$haveopt_ap=\"\$2\""
          else
            haveopt_optind=$(( haveopt_optind + 1 ))
            haveopt_optarg="$haveopt_optname"
            haveopt_optname=:
            eval "$haveopt_ap=\"\$haveopt_optarg\""
          fi
        else
          haveopt_optind=$(( haveopt_optind + 1 ))
          eval "unset $haveopt_ap"
        fi
        eval "$haveopt_ip=\$haveopt_optind"
        eval "$haveopt_np=\"\$haveopt_optname\""
        eval "$haveopt_cookie=\$haveopt_bit"
        return
      ;;
      -$haveopt_optname?*)
        # *not* the last option in the bundle
        # *or* a stuck haveopt_optarg
        haveopt_bit=$(( haveopt_bit + 1 ))
        if [ $haveopt_needs_optarg -ne 0 ]; then
          # stuck haveopt_optarg
          haveopt_bit=0
          eval "$haveopt_ap=\"\${haveopt_arg#-?}\""
          haveopt_optind=$(( haveopt_optind + 1 ))
        else
          eval "unset $haveopt_ap"
        fi
        eval "$haveopt_ip=\$haveopt_optind"
        eval "$haveopt_np=\"\$haveopt_optname\""
        eval "$haveopt_cookie=\$haveopt_bit"
        return
      ;;
      esac
    done # }}}

    # no, it's none of the known options {{{
    haveopt_optname="${haveopt_arg#-}"
    case $haveopt_optname in
    ?)
      haveopt_bit=0
      haveopt_optind=$(( haveopt_optind + 1 ))
    ;;
    *)
      local haveopt_tail haveopt_tlen=$(( ${#haveopt_optname} - 1 ))
      haveopt_tail="$(
        printf "%${haveopt_tlen}s" '' | tr ' ' '?'
      )"
      haveopt_optname="${haveopt_optname%$haveopt_tail}"
      haveopt_bit=$(( haveopt_bit + 1 ))
    ;;
    esac
    eval "$haveopt_ip=\$haveopt_optind"
    eval "$haveopt_np=?"
    eval "$haveopt_ap=\"\$haveopt_optname\""
    eval "$haveopt_cookie=\$haveopt_bit"
    return
    # }}}
    # }}}
  ;;
  esac

  # not an option or option-bundle
  eval "$haveopt_ip=\$haveopt_optind"
  eval "$haveopt_np='?'"
  eval "unset $haveopt_ap"
  unset $haveopt_cookie
  # }}}

  return 1
}
