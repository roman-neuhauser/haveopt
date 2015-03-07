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
  eval "$ip=\$i"

  shift $i

  i=$(( i + 1 ))
  local arg="$1"
  local optarg="${2:-}"

  # name of the cookie used to store
  # the iterator over bundled short options
  local cookie="HAVEOPT_shopt_iter__$ip_$np_$ap"
  local bit
  local bundle=0
  eval "bit=\"\${$cookie:-0}\""

  local haveopt_iteration

  for haveopt_iteration in 1 2 3; do
    [ $haveopt_iteration -lt 3 ] || {
      printf >&2 -- "haveopt: internal error.  infinite loop detected.\n"
      return 2
    }

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
          eval "$np=\"\$optname\""
          eval "$ap=\"\${arg#--\$optname=}\""
          eval "$ip=\$i"
          return 0
        ;;
        --$optname)
          eval "$np=\"\$optname\""
          if [ $needs_optarg -ne 0 ]; then
            i=$(( i + 1 ))
            eval "$ap=\"\$2\""
          else
            eval "$ap="
          fi
          eval "$ip=\$i"
          return 0
        ;;
        esac
      done
      return 1
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
          eval "$np=\"\$optname\""
          if [ $needs_optarg -ne 0 ]; then
            i=$(( i + 1 ))
            eval "$ap=\"\$optarg\""
          else
            eval "$ap="
          fi
          if [ $bundle -ne 0 ]; then
            eval "$cookie=\$bit"
          else
            eval "$ip=\$i"
          fi
          return 0
        ;;
        esac
      done
      return 1
      # }}}
    ;;
    -??*)
      # bundle of short options {{{
      bundle=1
      local opts="${arg#-}"
      local blen=${#opts}
      if [ $blen -eq $bit ]; then
        eval "$ip=\$i"
        return 1
      fi
      local tlen=$(( (0 < (blen - bit)) ? (blen - bit - 1) : 0 ))
      local prev="$(printf "%${bit}s" '' | tr ' ' '?')"
      local rest="$(printf "%${tlen}s" '' | tr ' ' '?')"
      arg="${opts#$prev}"
      arg="${arg%$rest}"
      arg="-$arg"
      optarg="${opts#$prev?}"
      bit=$(( bit + 1 ))
      continue
      # }}}
    ;;
    esac
    return 1
  done

  return 1
}
