#uname -a && lsb_release -a && hostname && df -h && env|grep ORA && ps -ef|grep pmon && ps -ef|grep tns && top && vmstat 2 10

uname -a > Action_`date +%Y%m%d`.txt && lsb_release -a >> Action_`date +%Y%m%d`.txt && hostname >> Action_`date +%Y%m%d`.txt && whoami >> Action_`date +%Y%m%d`.txt && id >> Action_`date +%Y%m%d`.txt && df -h >> Action_`date +%Y%m%d`.txt && env|grep ORA >> Action_`date +%Y%m%d`.txt && ps -ef|grep pmon >> Action_`date +%Y%m%d`.txt && ps -ef|grep tns >> Action_`date +%Y%m%d`.txt && lsnrctl status >> Action_`date +%Y%m%d`.txt && free -mt >> Action_`date +%Y%m%d`.txt && vmstat 2 10 >> Action_`date +%Y%m%d`.txt && pwd >> Action_`date +%Y%m%d`.txt && ls -lhtr