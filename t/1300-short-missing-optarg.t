short options, missing optarg
=============================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::


  $ I=0 N= A=

  $ tool I N A a b= -- -a -b
  I=1
  N=a
  A=

  $ tool I N A a b= -- -a -b
  I=2
  N=:
  A=b

  $ tool I N A a b= -- -a -b
  I=2
  N=?
  A=
  [1]

  $ tool I N A a b= -- -a -b
  I=2
  N=?
  A=
  [1]
