error handling: 
============================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ tool0()
  > {
  >   local opt i arg
  >   while haveopt i opt arg a b= -- "$@"; do
  >     printf -- "-- opt='%s' OPTARG='%s' OPTIND=%s\n" \
  >       "$opt" "$arg" "$i"
  >   done
  > }

  $ tool0 -a -b x fubar
  -- opt='a' OPTARG='' OPTIND=1
  -- opt='b' OPTARG='x' OPTIND=3

  $ tool0 -a -b
  -- opt='a' OPTARG='' OPTIND=1
  -- opt=':' OPTARG='b' OPTIND=2

  $ tool1()
  > {
  >   local opt i arg
  >   while haveopt i opt arg aa bb= -- "$@"; do
  >     printf -- "-- opt='%s' OPTARG='%s' OPTIND=%s\n" \
  >       "$opt" "$arg" "$i"
  >   done
  > }

  $ tool1 --aa --bb x fubar
  -- opt='aa' OPTARG='' OPTIND=1
  -- opt='bb' OPTARG='x' OPTIND=3

  $ tool1 --aa --bb
  -- opt='aa' OPTARG='' OPTIND=1
  -- opt=':' OPTARG='bb' OPTIND=2

  $ tool2()
  > {
  >   local opt i arg
  >   while haveopt i opt arg a b= -- "$@"; do
  >     printf -- "-- opt='%s' OPTARG='%s' OPTIND=%s\n" \
  >       "$opt" "$arg" "$i"
  >   done
  > }

  $ tool2 -ab x fubar
  -- opt='a' OPTARG='' OPTIND=0
  -- opt='b' OPTARG='x' OPTIND=2

  $ tool2 -ab
  -- opt='a' OPTARG='' OPTIND=0
  -- opt=':' OPTARG='b' OPTIND=1

