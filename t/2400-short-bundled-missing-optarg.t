short options, bundled, missing optarg
======================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ I=0 N= A=

  $ tool I N A b o w= -- -bow
  I=0
  N=b
  A=

  $ tool I N A b o w= -- -bow
  I=0
  N=o
  A=

  $ tool I N A b o w= -- -bow
  I=1
  N=:
  A=w

  $ tool I N A b o w= -- -bow
  I=1
  N=?
  A=
  [1]

  $ tool I N A b o w= -- -bow
  I=1
  N=?
  A=
  [1]

