#!/bin/sh
# hacked up by xiaolong (xiaolonw@cs.cmu.edu)
# Feb 6th, 2016
# Run like: ./latedays_starter.sh script_name 
# Logs are written to /home/${USER}/SToutputs/

if [ ! -n "$1" ]
    then
    echo "Usage: " $0 " script_to_run"
    exit
else
    PROCSTRING=$1
    echo "Running: " $PROCSTRING
fi


if [ ! -n "$2" ]
    then
    WT=72
    echo "Defaulting WT to ${WT}"
else
    WT=$2
fi
#-N gives the name so that qstat and showq will display this name
# nodes=1 means we are handling parallelization at the high level and run non-MPI jobs
#-e and -o are the stderr and stdout logs
#-eo means that they are joined
#-v passes a command line argument into latedays_driver.sh (so the driver knows what to execute!)

LOGDIR=/home/${USER}/STOutputs

if [ ! -d ${LOGDIR} ]; then
    echo "Directory ${LOGDIR} not present, creating it"
    mkdir $LOGDIR
fi

LOGSTRING="-e ${LOGDIR} -o ${LOGDIR} -j oe"


qsub -q gpujobs-16824 -N ${PROCSTRING} -l walltime=${WT}:00:00 -l nodes=1:ppn=8 ${LOGSTRING} -v PROCSTRING=${PROCSTRING} latedays_driver_train.sh
