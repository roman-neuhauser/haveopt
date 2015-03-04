short options, with separate optargs
====================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ set I N A o= w -- -o lol -w rofl lmao

  $ I=0 N= A=

  $ haveopt "$@"
  $ dump I N A
  I=2
  N=o
  A=lol

  $ haveopt "$@"
  $ dump I N A
  I=3
  N=w
  A=

  $ haveopt "$@"
  [1]
  $ dump I N A
  I=3
  N=w
  A=
