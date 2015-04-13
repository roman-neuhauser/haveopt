gross misuse: invalid parameter names
=====================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ I=foo N=bar A=qux
  $ haveopt - N A --
  haveopt: invalid identifier: -
  [2]
  $ dump I N A
  I=foo
  N=bar
  A=qux

  $ I=foo N=bar A=qux
  $ haveopt I '#' A --
  haveopt: invalid identifier: #
  [2]
  $ dump I N A
  I=foo
  N=bar
  A=qux

  $ I=foo N=bar A=qux
  $ haveopt I N 4 --
  haveopt: invalid identifier: 4
  [2]
  $ dump I N A
  I=foo
  N=bar
  A=qux

  $ I=foo N=bar A=qux
  $ haveopt I _0 4 --
  haveopt: invalid identifier: 4
  [2]
  $ dump I N A
  I=foo
  N=bar
  A=qux

  $ I=foo N=bar A=qux
  $ haveopt I _! 4 --
  haveopt: invalid identifier: _!
  [2]
  $ dump I N A
  I=foo
  N=bar
  A=qux
