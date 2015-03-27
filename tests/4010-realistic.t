realistic use
=============

setup
*****

::

  $ . $TESTDIR/setup
  $ . $TESTDIR/samples
  $ . $TESTDIR/samples.d/comm

test
****

::

  $ pretend comm -12 file.v1 file.v2
  suppress column 1 (lines unique to FILE1)
  suppress column 2 (lines unique to FILE2)
  operands (2):
   - file.v1
   - file.v2

  $ pretend comm -21 file.v1 file.v2
  suppress column 2 (lines unique to FILE2)
  suppress column 1 (lines unique to FILE1)
  operands (2):
   - file.v1
   - file.v2

  $ pretend comm -123 file.v1 file.v2
  suppress column 1 (lines unique to FILE1)
  suppress column 2 (lines unique to FILE2)
  suppress column 3 (lines that appear in both files)
  operands (2):
   - file.v1
   - file.v2

  $ pretend comm -14 file.v1 file.v2
  suppress column 1 (lines unique to FILE1)
  error: unknown option 4
  [1]
