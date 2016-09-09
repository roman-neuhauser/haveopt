minimal use: requesting help
============================

setup
*****

::

  $ . $TESTDIR/setup

test
****

::

  $ haveopt -h
  usage: haveopt IND OPT ARG [OPTSPEC...] -- "$@"

  $ haveopt --help
  usage: haveopt IND OPT ARG [OPTSPEC...] -- "$@"

