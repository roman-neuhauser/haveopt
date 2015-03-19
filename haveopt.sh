# vim: ft=sh ts=2 sts=2 sw=2 et fdm=marker cms=\ #\ %s

haveopt()
{
  # configuration {{{
  local haveopt_usage='usage: haveopt IND OPT ARG [OPTSPEC...] -- "$@"\n'

  if [ $# -eq 1 ]; then
    case $1 in
      -h|--help) printf >&2 "$haveopt_usage" ;;
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

  local haveopt_ip="$1" haveopt_np="$2" haveopt_ap="$3"; shift 3

  local haveopt_sopts= haveopt_soptstr= haveopt_lopts=

  while [ "x$1" != x-- ]; do
    case "$1" in
    ?=|?)
      haveopt_sopts="$haveopt_sopts $1"
      haveopt_soptstr="$haveopt_soptstr${1%=}"
    ;;
    *)
      haveopt_lopts="$haveopt_lopts $1"
    ;;
    esac
    shift
  done
  # remove the '--' optspeclist terminator
  # leaving the actual args in $@
  shift
  # }}}

  # one shot {{{
  local haveopt_optind
  eval "haveopt_optind=\"\$$haveopt_ip\""
  haveopt_optind=$(expr "$haveopt_optind" : '\([0-9]*\)' \| 0)

  shift $haveopt_optind

  local haveopt_arg="${1-}"
  local haveopt_opt
  local haveopt_optarg
  local haveopt_optname
  local haveopt_needs_optarg=0

  case $haveopt_arg in
  --)
    haveopt_optind=$(( haveopt_optind + 1 ))
    break
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
        eval "$haveopt_np=\"\$haveopt_optname\""
        if [ $haveopt_needs_optarg -ne 0 ]; then
          haveopt_optind=$(( haveopt_optind + 2 ))
          eval "$haveopt_ap=\"\$2\""
        else
          haveopt_optind=$(( haveopt_optind + 1 ))
          eval "unset $haveopt_ap"
        fi
        eval "$haveopt_ip=\$haveopt_optind"
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
          haveopt_optind=$(( haveopt_optind + 2 ))
          haveopt_optarg="$2"
          eval "$haveopt_ap=\"\$2\""
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

    haveopt_arg="-${haveopt_arg#-$(
      printf "%${haveopt_bit}s" '' | tr ' ' '?'
    )}"

    for haveopt_opt in $haveopt_sopts; do # {{{
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
          haveopt_optind=$(( haveopt_optind + 2 ))
          eval "$haveopt_ap=\"\$2\""
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
  ;;
  esac

  eval "$haveopt_ip=\$haveopt_optind"
  eval "$haveopt_np='?'"
  eval "unset $haveopt_ap"
  unset $haveopt_cookie
  # }}}

  return 1
}
