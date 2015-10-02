#!/bin/bash
DIR="/home/ansible/log/"
NAME="ansible.cron.run.log"
TIME=$(date +%Y%m%d-%H:%M:%S)
TMP="/dev/shm/${TIME}${NAME}"
LOG="${DIR}${NAME}"
echo "${TIME} ansible-playbook $@" >> ${LOG}
ansible-playbook "$@" >> ${TMP}
if [ $? -ne 0 ]
    then
    cat ${TMP} >> ${LOG}
    else
    cat ${TMP} | grep -B1 -e 'changed:' >> ${LOG}
fi
rm ${TMP}
