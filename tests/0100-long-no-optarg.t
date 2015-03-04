long options, no optargs
========================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ set I N A omg wtf -- --omg --wtf rofl lmao

  $ I=0 N= A=

  $ haveopt "$@"
  $ dump I N A
  I=1
  N=omg
  A=

  $ haveopt "$@"
  $ dump I N A
  I=2
  N=wtf
  A=

  $ haveopt "$@"
  [1]
  $ dump I N A
  I=2
  N=wtf
  A=
