minimal use: no optspecs, some arguments
========================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ I=0 N= A=
  $ tool I N A -- foo bar baz qux
  I=0
  N=?
  A=
  [1]
