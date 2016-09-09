"--" ends option processing
===========================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ I=0

  $ tool I N A a b c -- -a -b -- -c
  I=1
  N=a
  A=
  $ tool I N A a b c -- -a -b -- -c
  I=2
  N=b
  A=
  $ tool I N A a b c -- -a -b -- -c
  I=3
  N=?
  A=
  [1]

