long options, including unknown one
===================================

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

  $ tool --omg --snafu --fubar --wtf rofl lmao
  I=1
  N=omg
  A=

  $ tool --omg --snafu --fubar --wtf rofl lmao
  I=2
  N=?
  A=snafu

  $ tool --omg --snafu --fubar --wtf rofl lmao
  I=3
  N=?
  A=fubar

  $ tool --omg --snafu --fubar --wtf rofl lmao
  I=4
  N=wtf
  A=

  $ tool --omg --snafu --fubar --wtf rofl lmao
  I=4
  N=?
  A=
  [1]
