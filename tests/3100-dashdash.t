"--" ends option processing
===========================

setup
*****

::

  $ . $TESTDIR/setup

  $ channels='I N A'
  $ optspecs='a b c'

test
****

::

  $ I=0

  $ tool -a -b -- -c
  I=1
  N=a
  A=
  $ tool -a -b -- -c
  I=2
  N=b
  A=
  $ tool -a -b -- -c
  I=3
  N=?
  A=
  [1]

