long options, with stuck optargs
================================

setup
*****

::

  $ . $TESTDIR/setup

  $ channels='I N A'
  $ optspecs='omg= wtf'

test
****

::

  $ I=0 N= A=

  $ tool --omg=lol --wtf rofl lmao
  I=1
  N=omg
  A=lol

  $ tool --omg=lol --wtf rofl lmao
  I=2
  N=wtf
  A=

  $ tool --omg=lol --wtf rofl lmao
  I=2
  N=wtf
  A=
  [1]
