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

  $ dump I N A
  I=
  N=
  A=

  $ haveopt I N A
  usage: haveopt IND OPT ARG [OPTSPEC...] -- "$@"
  [2]

  $ dump I N A
  I=
  N=
  A=

  $ haveopt I N A foo bar= --foo --bar baz
  usage: haveopt IND OPT ARG [OPTSPEC...] -- "$@"
  [2]

  $ dump I N A
  I=
  N=
  A=
