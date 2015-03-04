short options, bundled, unknown option
======================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ set I N A b o w -- -blow rofl lmao

  $ I=0 N= A=

  $ haveopt "$@"
  $ dump I N A
  I=0
  N=b
  A=

  $ haveopt "$@"
  [1]
  $ dump I N A
  I=0
  N=b
  A=

