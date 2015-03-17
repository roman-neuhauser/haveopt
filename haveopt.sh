# vim: ft=sh ts=2 sts=2 sw=2 et fdm=marker cms=\ #\ %s

# TODO: get rid of this with some clever reparsing trickery.
# TODO: the goal is the `haveopt` function being the only
# TODO: statement as seen by a shell sourcing this file.
case "$0" in
*/haveopt)
  printf >&2 "you need to source the script with '. haveopt' and use the eponymous function\n"
  exit 1
esac

haveopt()
{
  # {{{
  local usage='usage: haveopt IND OPT ARG [OPTSPEC...] -- "$@"\n'

  if [ $# -le 3 ]; then
    printf >&2 "$usage"
    return 2
  fi
  if [ $# -eq 4 ] && [ "x$4" != x-- ]; then
    printf >&2 "$usage"
    return 2
  fi
  
  # name of the cookie used to store
  # the iterator over bundled short options
  local cookie="HAVEOPT_shopt_iter__$(printf "%s\0" "$@" | cksum | tr ' ' _)"

  local ip="$1" np="$2" ap="$3"; shift 3

  local sopts soptstr lopts

  while [ "x$1" != x-- ]; do
    case "$1" in
    ?=|?)
      sopts="$sopts $1"
      soptstr="$soptstr${1%=}"
    ;;
    *)
      lopts="$lopts $1"
    ;;
    esac
    shift
  done
  # remove the '--' optspeclist terminator
  # leaving the actual args in $@
  shift
  # }}}

  local i
  eval "i=\"\$$ip\""
  i=$(expr "$i" : '\([0-9]*\)' \| 0)

  shift $i

  local arg="$1"
  local opt
  local optarg

  case $arg in
  --?*)
    # long option {{{
    for opt in $lopts; do
      local optname=${opt%=}
      local needs_optarg=0
      case "$opt" in
      *=) needs_optarg=1 ;;
      esac
      case "$arg" in
      --$optname=*)
        i=$(( i + 1 ))
        optarg="${arg#--$optname=}"
        eval "$np=\"\$optname\""
        eval "$ap=\"\$optarg\""
        eval "$ip=\$i"
        return 0
      ;;
      --$optname)
        eval "$np=\"\$optname\""
        if [ $needs_optarg -ne 0 ]; then
          i=$(( i + 2 ))
          eval "$ap=\"\$2\""
        else
          i=$(( i + 1 ))
          eval "$ap="
        fi
        eval "$ip=\$i"
        return 0
      ;;
      esac
    done
    # }}}
  ;;
  -?)
    # short option {{{
    for opt in $sopts; do
      local optname=${opt%=}
      local needs_optarg=0
      case "$opt" in
      *=) needs_optarg=1 ;;
      esac
      case "$arg" in
      -$optname)
        # i'm torn: brevity or side-by-side view?
        if [ $needs_optarg -ne 0 ]; then
          i=$(( i + 2 ))
          optarg="$2"
        else
          i=$(( i + 1 ))
          optarg=
        fi
        eval "$ip=\$i"
        eval "$np=\"\$optname\""
        eval "$ap=\"\$optarg\""
        # no cookie
        return 0
      ;;
      esac
    done
    # }}}
  ;;
  -??*)
    # bundle of short options {{{
    local bit
    eval "bit=\"\${$cookie:-0}\""

    local prev="$(printf "%${bit}s" '' | tr ' ' '?')"
    arg="-${arg#-$prev}"

    for opt in $sopts; do # {{{
      local optname=${opt%=}
      local needs_optarg=0
      case "$opt" in
      *=) needs_optarg=1 ;;
      esac
      case "$arg" in
      -$optname)
        # last option in the bundle
        bit=0
        if [ $needs_optarg -ne 0 ]; then
          i=$(( i + 2 ))
          optarg="$2"
        else
          i=$(( i + 1 ))
          optarg=
        fi
        eval "$ip=\$i"
        eval "$np=\"\$optname\""
        eval "$ap=\"\$optarg\""
        eval "$cookie=\$bit"
        return
      ;;
      -$optname?*)
        # *not* the last option in the bundle
        # *or* a stuck optarg
        bit=$(( bit + 1 ))
        if [ $needs_optarg -ne 0 ]; then
          # stuck optarg
          bit=0
          optarg="${arg#-?}"
          i=$(( i + 1 ))
        else
          optarg=
        fi
        eval "$ip=\$i"
        eval "$np=\"\$optname\""
        eval "$ap=\"\$optarg\""
        eval "$cookie=\$bit"
        return
      ;;
      esac
    done # }}}
    # }}}
  ;;
  esac

  eval "$ip=\$i"
  unset $cookie

  return 1
}
