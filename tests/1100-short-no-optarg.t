short options, no optargs
=========================

setup
*****

::

  $ . $TESTDIR/setup

  $ channels='I N A'
  $ optspecs='o w'

test
****

::


  $ I=0 N= A=

  $ tool -o -w rofl lmao
  I=1
  N=o
  A=

  $ tool -o -w rofl lmao
  I=2
  N=w
  A=

  $ tool -o -w rofl lmao
  I=2
  N=?
  A=
  [1]
