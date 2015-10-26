"--" ends option processing
===========================

setup
*****

::

  $ test "${ZSH_VERSION-unset}" = unset || exit 80
  $ . $TESTDIR/setup

test
****

::

  $ OPTIND=1

  $ getopts abc OPTNAM -a -b -- -c
  $ dump OPTIND OPTNAM OPTARG
  OPTIND=2
  OPTNAM=a
  OPTARG=(<empty>)? (re)
  $ getopts abc OPTNAM -a -b -- -c
  $ dump OPTIND OPTNAM OPTARG
  OPTIND=3
  OPTNAM=b
  OPTARG=(<empty>)? (re)
  $ getopts abc OPTNAM -a -b -- -c
  [1]
  $ dump OPTIND OPTNAM OPTARG
  OPTIND=4
  OPTNAM=?
  OPTARG=(<empty>)? (re)
