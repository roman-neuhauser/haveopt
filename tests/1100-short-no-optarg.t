short options, no optargs
=========================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ set I N A o w -- -o -w rofl lmao

  $ I=0 N= A=

  $ haveopt "$@"
  $ dump I N A
  I=1
  N=o
  A=

  $ haveopt "$@"
  $ dump I N A
  I=2
  N=w
  A=

  $ haveopt "$@"
  [1]
  $ dump I N A
  I=2
  N=w
  A=
