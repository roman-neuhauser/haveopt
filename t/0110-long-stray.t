long options, including unknown one
===================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ I=0 N= A=

  $ tool I N A omg wtf -- --omg --snafu --fubar --wtf rofl lmao
  I=1
  N=omg
  A=

  $ tool I N A omg wtf -- --omg --snafu --fubar --wtf rofl lmao
  I=2
  N=?
  A=snafu

  $ tool I N A omg wtf -- --omg --snafu --fubar --wtf rofl lmao
  I=3
  N=?
  A=fubar

  $ tool I N A omg wtf -- --omg --snafu --fubar --wtf rofl lmao
  I=4
  N=wtf
  A=

  $ tool I N A omg wtf -- --omg --snafu --fubar --wtf rofl lmao
  I=4
  N=?
  A=
  [1]
