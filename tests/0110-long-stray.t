long options, including unknown one
===================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ tool()
  > {
  >   local ex=0
  >   haveopt I N A omg wtf -- "$@" || ex=$?
  >   dump I N A
  >   return $ex
  > }


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
  N=wtf
  A=
  [1]
