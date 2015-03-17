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
  $ haveopt I N A -- --foo -b -a -r -baz qux
  $ dump I N A
  I=1
  N=?
  A=foo

  $ haveopt I N A -- --foo -b -a -r -baz qux
  $ dump I N A
  I=2
  N=?
  A=b

  $ haveopt I N A -- --foo -b -a -r -baz qux
  $ dump I N A
  I=3
  N=?
  A=a

  $ haveopt I N A -- --foo -b -a -r -baz qux
  $ dump I N A
  I=4
  N=?
  A=r

  $ haveopt I N A -- --foo -b -a -r -baz qux
  $ dump I N A
  I=4
  N=?
  A=b

