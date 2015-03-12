short options, bundled, space, optarg
=====================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ set I N A b l= -- -bl ow rofl lmao

  $ I=0 N= A=

  $ haveopt "$@"
  $ dump I N A
  I=0
  N=b
  A=

  $ haveopt "$@"
  $ dump I N A
  I=2
  N=l
  A=ow

  $ haveopt "$@"
  [1]
  $ dump I N A
  I=2
  N=l
  A=ow

