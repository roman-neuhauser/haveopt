long options, with separate optargs
===================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ set I N A omg= wtf -- --omg lol --wtf rofl lmao

  $ I=0 N= A=

  $ haveopt "$@"
  $ dump I N A
  I=2
  N=omg
  A=lol

  $ haveopt "$@"
  $ dump I N A
  I=3
  N=wtf
  A=

  $ haveopt "$@"
  [1]
  $ dump I N A
  I=3
  N=wtf
  A=
