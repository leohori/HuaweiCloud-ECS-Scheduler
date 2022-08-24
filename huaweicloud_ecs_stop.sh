#!/bin/bash
#################################################################
# Author: Horikian, Leonardo (leonardo.horikian@huawei.com)     #
# Team: Huawei Cloud Team Argentina                             #
# Description: Script to stop an Elastic Cloud Servers.         #
# Date: 09-March-2020                                           #
# Version: 1.0                                                  #
# Pre-Requisits: OpenStack SDK.                                 #
#################################################################

clear

openstack server stop $1
