multiple uses in the same scope
===============================

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
  >   haveopt I N A a b= c d -- "$@" || ex=$?
  >   dump I N A
  >   return $ex
  > }

  $ I=0 N= A=

  $ tool -abcd -cd
  I=0
  N=a
  A=

  $ tool -abcd -cd
  I=1
  N=b
  A=cd

  $ tool -abcd -cd
  I=1
  N=b
  A=cd
  [1]

  $ I=0 N= A=

  $ tool -cad -dca -badc
  I=0
  N=c
  A=

  $ tool -cad -dca -badc
  I=0
  N=a
  A=

  $ tool -cad -dca -badc
  I=1
  N=d
  A=

  $ tool -cad -dca -badc
  I=1
  N=d
  A=

  $ tool -cad -dca -badc
  I=1
  N=c
  A=

  $ tool -cad -dca -badc
  I=2
  N=a
  A=

  $ tool -cad -dca -badc
  I=3
  N=b
  A=adc

  $ tool -cad -dca -badc
  I=3
  N=b
  A=adc
  [1]

