basic misuse: wrong number of arguments etc.
============================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ haveopt
  usage: haveopt IND OPT ARG [OPTSPEC...] -- "$@"
  [2]

  $ haveopt I N A
  usage: haveopt IND OPT ARG [OPTSPEC...] -- "$@"
  [2]
  $ dump I N A
  I=
  N=
  A=
