#!/bin/bash
#################################################################
# Author: Horikian, Leonardo (leonardo.horikian@huawei.com)     #
# Team: Huawei Cloud Team Argentina                             #
# Description: Script that allows start, stop and list the      #
#              Elastic Cloud Servers created. Also, schedule    #
#              the start and stop of specifics ECS              #
#              through crontab.                                 #
# Date: 09-March-2020                                           #
# Version: 1.0                                                  #
# Pre-Requisits: OpenStack SDK.                                 #
# Execution: sh huaweicloud_ecs_scheduler.sh                    #
#################################################################

clear

PATH_ECS=/home/huaweicloud/huaweicloud_ecs_scheduler

. $PATH_ECS/huaweicloud_ecs_env.sh

cNone='\033[00m'
cRed='\033[01;31m'
cGreen='\033[01;32m'
cYellow='\033[01;33m'
cPurple='\033[01;35m'
cCyan='\033[01;36m'
cWhite='\033[01;37m'
cBold='\033[1m'
cUnderline='\033[4m'

pause(){
  	read -p "Press [Enter] to continue..." fackEnterKey
}

choose_ecs(){
	clear
	openstack server list -c Name -c Status -c Image -c Flavor --status $1
}

start_ecs(){
	clear
	choose_ecs SHUTOFF
    read -p "Type the name of the ECS: " name_ecs
	openstack server start $name_ecs
}
 
stop_ecs(){
	clear
	choose_ecs ACTIVE
	read -p "Type the name of the ECS: " name_ecs
    openstack server stop $name_ecs
}

list_ecs(){
	clear
	openstack server list -c Name -c Status -c Image -c Flavor 
}

schedule_ecs(){
	clear
    list_ecs
	echo "" 
	read -p "Type the name of the ECS (Example: ecs_prueba): " name_ecs
	read -p "Type if you want to schedule an START or STOP action (Example: start): " action_ecs
	read -p "Type the crontab frequency to shedule (Example: 00 19 * * 1-5): " frequency_ecs
	action_ecs=`echo "$action_ecs" | tr '[:upper:]' '[:lower:]'`
	printf "$(crontab -l ; echo "$frequency_ecs"' . '$PATH_ECS'/huaweicloud_ecs_env.sh; sh '$PATH_ECS'/huaweicloud_ecs_'$action_ecs'.sh '$name_ecs' >> '$PATH_ECS'/huaweicloud_ecs_'$action_ecs'.log 2>&1')\n" | crontab -
}

list_scheduled_ecs(){
	clear
	crontab -l | grep $PATH_ECS 
}

show_menu() {
	echo "${cRed}"
	echo "~~~~~~~~~~~~~~~~~~~~~~"
	echo "**** HUAWEI CLOUD ****"
	echo "~~~~~~~~~~~~~~~~~~~~~~"
	echo "    ECS Scheduler     "
	echo "~~~~~~~~~~~~~~~~~~~~~~"
    echo "${cNone}"
	echo "DOMAIN_NAME: "$OS_DOMAIN_NAME
	echo "PROJECT_NAME: "$OS_PROJECT_NAME
	echo "USERNAME: "$OS_USERNAME
	echo ""
	echo "${cYellow}IMMEDIATE EXECUTION:${cNone}"
	echo "1) Start ECS"
	echo "2) Stop ECS"
	echo "3) List ECS"
	echo ""
	echo "${cYellow}SCHEDULE EXECUTION:${cNone}"
	echo "4) Schedule Start/Stop ECS"
	echo "5) List Scheduled ECS"
	echo ""
	echo "6) Exit"
	echo ""
}

read_menu(){
	local option
	read -p "Choose an option [ 1 - 6 ] " option
	case $option in
		1) start_ecs ;;
		2) stop_ecs ;;
		3) list_ecs ;;
		4) schedule_ecs ;;
		5) list_scheduled_ecs ;;
		6) exit 0 ;;
		*) echo "" && echo "${cRed}Error...${cNone}" && sleep 2 && clear
	esac
}

while true
do
	show_menu
	read_menu
done

