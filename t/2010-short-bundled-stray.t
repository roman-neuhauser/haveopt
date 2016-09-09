short options, bundled, unknown option
======================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ I=0 N= A=

  $ tool I N A b o w -- -blow rofl lmao
  I=0
  N=b
  A=

  $ tool I N A b o w -- -blow rofl lmao
  I=0
  N=?
  A=l

  $ tool I N A b o w -- -blow rofl lmao
  I=0
  N=o
  A=

  $ tool I N A b o w -- -blow rofl lmao
  I=1
  N=w
  A=

  $ tool I N A b o w -- -blow rofl lmao
  I=1
  N=?
  A=
  [1]

