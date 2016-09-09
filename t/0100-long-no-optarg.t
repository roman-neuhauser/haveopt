long options, no optargs
========================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ I=0 N= A=

  $ tool I N A omg wtf -- --omg --wtf rofl lmao
  I=1
  N=omg
  A=

  $ tool I N A omg wtf -- --omg --wtf rofl lmao
  I=2
  N=wtf
  A=

  $ tool I N A omg wtf -- --omg --wtf rofl lmao
  I=2
  N=?
  A=
  [1]
