short options, bundled, happy path
==================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ set I N A o l w -- -owl rofl lmao

  $ I=0 N= A=

  $ haveopt "$@"
  $ dump I N A
  I=0
  N=o
  A=

  $ haveopt "$@"
  $ dump I N A
  I=0
  N=w
  A=

  $ haveopt "$@"
  $ dump I N A
  I=0
  N=l
  A=

  $ haveopt "$@"
  [1]
  $ dump I N A
  I=1
  N=l
  A=
