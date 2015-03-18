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

::

  $ I=0 N= A=
  $ tool --foo -b -a -r -baz qux
  I=1
  N=?
  A=foo

  $ tool --foo -b -a -r -baz qux
  I=2
  N=?
  A=b

  $ tool --foo -b -a -r -baz qux
  I=3
  N=?
  A=a

  $ tool --foo -b -a -r -baz qux
  I=4
  N=?
  A=r

  $ tool --foo -b -a -r -baz qux
  I=4
  N=?
  A=b

  $ tool --foo -b -a -r -baz qux
  I=4
  N=?
  A=a

  $ tool --foo -b -a -r -baz qux
  I=5
  N=?
  A=z

  $ tool --foo -b -a -r -baz qux
  I=5
  N=?
  A=
  [1]
