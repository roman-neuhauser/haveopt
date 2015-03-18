short options, bundled, unknown option
======================================

setup
*****

::

  $ . $TESTDIR/setup

  $ channels='I N A'
  $ optspecs='b o w'

test
****

::

  $ I=0 N= A=

  $ tool -blow rofl lmao
  I=0
  N=b
  A=

  $ tool -blow rofl lmao
  I=0
  N=?
  A=l

  $ tool -blow rofl lmao
  I=0
  N=o
  A=

  $ tool -blow rofl lmao
  I=1
  N=w
  A=

  $ tool -blow rofl lmao
  I=1
  N=w
  A=
  [1]

