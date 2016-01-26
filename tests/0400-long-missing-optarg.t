long option, missing optarg
===========================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::


  $ I=0 N= A=

  $ tool I N A a boo= -- -a --boo
  I=1
  N=a
  A=

  $ tool I N A a boo= -- -a --boo
  I=2
  N=:
  A=boo

  $ tool I N A a boo= -- -a --boo
  I=2
  N=?
  A=
  [1]

  $ tool I N A a boo= -- -a --boo
  I=2
  N=?
  A=
  [1]
