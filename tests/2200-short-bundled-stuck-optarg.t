short options, bundled, stuck optarg
====================================

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

  $ tool -blow rofl lmao
  I=0
  N=b
  A=

  $ tool -blow rofl lmao
  I=1
  N=l
  A=ow

  $ tool -blow rofl lmao
  I=1
  N=l
  A=ow
  [1]

