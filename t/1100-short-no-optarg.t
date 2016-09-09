short options, no optargs
=========================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::


  $ I=0 N= A=

  $ tool I N A o w -- -o -w rofl lmao
  I=1
  N=o
  A=

  $ tool I N A o w -- -o -w rofl lmao
  I=2
  N=w
  A=

  $ tool I N A o w -- -o -w rofl lmao
  I=2
  N=?
  A=
  [1]
