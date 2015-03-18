short options, bundled, happy path
==================================

setup
*****

::

  $ . $TESTDIR/setup

  $ channels='I N A'
  $ optspecs='l o w'

test
****

::

  $ I=0 N= A=

  $ tool -owl rofl lmao
  I=0
  N=o
  A=

  $ tool -owl rofl lmao
  I=0
  N=w
  A=

  $ tool -owl rofl lmao
  I=1
  N=l
  A=

  $ tool -owl rofl lmao
  I=1
  N=?
  A=
  [1]
