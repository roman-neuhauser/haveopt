minimal use: no optspecs, no arguments
======================================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ I=0 N= A=
  $ haveopt I N A --
  [1]
  $ dump I N A
  I=0
  N=?
  A=

::

  $ I=foo N=bar A=qux
  $ haveopt I N A --
  [1]
  $ dump I N A
  I=0
  N=?
  A=
