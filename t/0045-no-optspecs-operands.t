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
  $ tool I N A -- --foo -b -a -r -baz qux
  I=1
  N=?
  A=foo

  $ tool I N A -- --foo -b -a -r -baz qux
  I=2
  N=?
  A=b

  $ tool I N A -- --foo -b -a -r -baz qux
  I=3
  N=?
  A=a

  $ tool I N A -- --foo -b -a -r -baz qux
  I=4
  N=?
  A=r

  $ tool I N A -- --foo -b -a -r -baz qux
  I=4
  N=?
  A=b

  $ tool I N A -- --foo -b -a -r -baz qux
  I=4
  N=?
  A=a

  $ tool I N A -- --foo -b -a -r -baz qux
  I=5
  N=?
  A=z

  $ tool I N A -- --foo -b -a -r -baz qux
  I=5
  N=?
  A=
  [1]
