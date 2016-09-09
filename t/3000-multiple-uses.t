multiple uses in the same scope
===============================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ I=0 N= A=

  $ tool I N A a b= c d -- -abcd -cd
  I=0
  N=a
  A=

  $ tool I N A a b= c d -- -abcd -cd
  I=1
  N=b
  A=cd

  $ tool I N A a b= c d -- -abcd -cd
  I=1
  N=c
  A=

  $ tool I N A a b= c d -- -abcd -cd
  I=2
  N=d
  A=

  $ tool I N A a b= c d -- -abcd -cd
  I=2
  N=?
  A=
  [1]

  $ I=0 N= A=

  $ tool I N A a b= c d -- -cad -dca -badc
  I=0
  N=c
  A=

  $ tool I N A a b= c d -- -cad -dca -badc
  I=0
  N=a
  A=

  $ tool I N A a b= c d -- -cad -dca -badc
  I=1
  N=d
  A=

  $ tool I N A a b= c d -- -cad -dca -badc
  I=1
  N=d
  A=

  $ tool I N A a b= c d -- -cad -dca -badc
  I=1
  N=c
  A=

  $ tool I N A a b= c d -- -cad -dca -badc
  I=2
  N=a
  A=

  $ tool I N A a b= c d -- -cad -dca -badc
  I=3
  N=b
  A=adc

  $ tool I N A a b= c d -- -cad -dca -badc
  I=3
  N=?
  A=
  [1]

