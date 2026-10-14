#!/bin/sh

DISTDIR="~luis/sunos_source/lse/distfiles/2.5.1/"
RELEASE_LOCATION="lsesol/releases/download/v0.9.0-sunos4-sparc/gcc-4.1.2-sparcv7-sunld/"


for a in `find $DISTDIR`; do
   echo "${RELEASE_LOCATION}/$a"
done
