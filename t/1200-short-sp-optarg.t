short options, with separate optargs
====================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ I=0 N= A=

  $ tool I N A o= w -- -o lol -w rofl lmao
  I=2
  N=o
  A=lol

  $ tool I N A o= w -- -o lol -w rofl lmao
  I=3
  N=w
  A=

  $ tool I N A o= w -- -o lol -w rofl lmao
  I=3
  N=?
  A=
  [1]
