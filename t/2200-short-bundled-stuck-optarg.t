short options, bundled, stuck optarg
====================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ I=0 N= A=

  $ tool I N A b l= -- -blow rofl lmao
  I=0
  N=b
  A=

  $ tool I N A b l= -- -blow rofl lmao
  I=1
  N=l
  A=ow

  $ tool I N A b l= -- -blow rofl lmao
  I=1
  N=?
  A=
  [1]

