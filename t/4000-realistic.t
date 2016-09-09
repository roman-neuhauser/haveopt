realistic use
=============

setup
*****

::

  $ . $TESTDIR/setup
  $ . $TESTDIR/samples
  $ . $TESTDIR/samples.d/bsdtar

test
****

::

  $ pretend bsdtar -caf random.tar.gz -C dist random
  create archive random.tar.gz
   - from operands found in dist/
   - infer compression from archive filename
  operands (1):
   - random

  $ pretend bsdtar -tf random.tar.gz
  list contents of archive random.tar.gz
  no operands

  $ pretend bsdtar -xf random.tar.gz --chroot -C /tmp
  extract from random.tar.gz
   - chrooted into /tmp
  no operands

  $ pretend bsdtar -xf random.tar.gz --chroot
  extract from random.tar.gz
   - chrooted into current directory
  no operands

  $ pretend bsdtar -tf random.tar.gz --chroot
  error: --chroot only works with extract mode
  [1]

