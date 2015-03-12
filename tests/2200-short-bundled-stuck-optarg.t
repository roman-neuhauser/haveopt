short options, bundled, stuck optarg
====================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ set I N A b l= -- -blow rofl lmao

  $ I=0 N= A=

  $ haveopt "$@"
  $ dump I N A
  I=0
  N=b
  A=

  $ haveopt "$@"
  $ dump I N A
  I=1
  N=l
  A=ow

  $ haveopt "$@"
  [1]
  $ dump I N A
  I=1
  N=l
  A=ow

