#!/bin/sh
# hacked up by xiaolong (xiaolonw@cs.cmu.edu)
# Run like: ./latedays_killer.sh job_id


echo "killing JOB: " $1
MYIDS=`qstat | grep ${USER} | grep $1 | awk -F. '{print $1}'`
echo "killing these ids: " $MYIDS
qdel $MYIDS

