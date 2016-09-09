short options, bundled, space, optarg
=====================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ I=0 N= A=

  $ tool I N A b l= -- -bl ow rofl lmao
  I=0
  N=b
  A=

  $ tool I N A b l= -- -bl ow rofl lmao
  I=2
  N=l
  A=ow

  $ tool I N A b l= -- -bl ow rofl lmao
  I=2
  N=?
  A=
  [1]

