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
  $ dump I N A
  I=0
  N=?
  A=l

  $ haveopt "$@"
  $ dump I N A
  I=0
  N=o
  A=

  $ haveopt "$@"
  $ dump I N A
  I=1
  N=w
  A=

  $ haveopt "$@"
  [1]
  $ dump I N A
  I=1
  N=w
  A=

