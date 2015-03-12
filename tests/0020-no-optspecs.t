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
  $ haveopt I N A -- foo bar baz qux
  [1]
  $ dump I N A
  I=0
  N=
  A=

::

  $ I=0 N= A=
  $ haveopt I N A -- --foo -bar --baz qux
  [1]
  $ dump I N A
  I=0
  N=
  A=

