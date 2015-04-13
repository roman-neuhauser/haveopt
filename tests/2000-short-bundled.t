short options, bundled, happy path
==================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ I=0 N= A=

  $ tool I N A l o w -- -owl rofl lmao
  I=0
  N=o
  A=

  $ tool I N A l o w -- -owl rofl lmao
  I=0
  N=w
  A=

  $ tool I N A l o w -- -owl rofl lmao
  I=1
  N=l
  A=

  $ tool I N A l o w -- -owl rofl lmao
  I=1
  N=?
  A=
  [1]
