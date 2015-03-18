short options, bundled, space, optarg
=====================================

setup
*****

::

  $ . $TESTDIR/setup

  $ channels='I N A'
  $ optspecs='b l='

test
****

::

  $ I=0 N= A=

  $ tool -bl ow rofl lmao
  I=0
  N=b
  A=

  $ tool -bl ow rofl lmao
  I=2
  N=l
  A=ow

  $ tool -bl ow rofl lmao
  I=2
  N=?
  A=
  [1]

