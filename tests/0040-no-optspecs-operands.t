minimal use: no optspecs, some arguments
========================================

setup
*****

::

  $ . $TESTDIR/setup

  $ channels='I N A'

test
****

::

  $ I=0 N= A=
  $ tool foo bar baz qux
  I=0
  N=?
  A=
  [1]
