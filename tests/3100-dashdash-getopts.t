"--" ends option processing
===========================

setup
*****

::

  $ . $TESTDIR/setup

  $ tool=getopts

test
****

::

  $ OPTIND=1

  $ tool abc -a -b -- -c
  I=2
  N=a
  A=
  $ tool abc -a -b -- -c
  I=3
  N=b
  A=
  $ tool abc -a -b -- -c
  I=4
  N=?
  A=
  [1]
