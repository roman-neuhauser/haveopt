long options, no optargs
========================

setup
*****

::

  $ . $TESTDIR/setup

  $ channels='I N A'
  $ optspecs='omg wtf'

test
****

::

  $ I=0 N= A=

  $ tool --omg --wtf rofl lmao
  I=1
  N=omg
  A=

  $ tool --omg --wtf rofl lmao
  I=2
  N=wtf
  A=

  $ tool --omg --wtf rofl lmao
  I=2
  N=?
  A=
  [1]
