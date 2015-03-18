short options, with separate optargs
====================================

setup
*****

::

  $ . $TESTDIR/setup

  $ channels='I N A'
  $ optspecs='o= w'

test
****

::

  $ I=0 N= A=

  $ tool -o lol -w rofl lmao
  I=2
  N=o
  A=lol

  $ tool -o lol -w rofl lmao
  I=3
  N=w
  A=

  $ tool -o lol -w rofl lmao
  I=3
  N=?
  A=
  [1]
