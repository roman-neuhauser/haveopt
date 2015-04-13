long options, with stuck optargs
================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ I=0 N= A=

  $ tool I N A omg= wtf -- --omg=lol --wtf rofl lmao
  I=1
  N=omg
  A=lol

  $ tool I N A omg= wtf -- --omg=lol --wtf rofl lmao
  I=2
  N=wtf
  A=

  $ tool I N A omg= wtf -- --omg=lol --wtf rofl lmao
  I=2
  N=?
  A=
  [1]
