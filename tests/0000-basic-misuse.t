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

  $ I=foo N=bar A=qux
  $ haveopt I N A --
  [1]
  $ dump I N A
  I=0
  N=bar
  A=qux
