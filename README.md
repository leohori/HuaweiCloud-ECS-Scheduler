# Huawei Cloud - ECS Service - Scheduler

## Requirements

Linux with OpenStack Client.

UBUNTU client installation:

```
sudo apt update

sudo apt upgrade

sudo apt-get install python python-setuptools python-pip python-dev

sudo pip install python-openstackclient

openstack --help
```

Note: If you get the error "ImportError: No module named queue" after the execution of openstack command, please execute the following fix:

```
vi /usr/lib/python2.7/site-packages/openstack/cloud/openstackcloud.py
vi /usr/lib/python2.7/site-packages/openstack/utils.py
```

In both files, replace:

```
"import queue" 
```
with:
```
from multiprocessing import Queue as queue
```

Set the following variables in the huaweicloud_ecs_env.sh
```
OS_DOMAIN_NAME : Domain Name of your Huawei Cloud account
OS_USERNAME : Username of your Huawei Cloud account
OS_PASSWORD : Password of your Huawei Cloud account
OS_PROJECT_NAME : Project Name of your Huawei Cloud account
```

Set the following variables in the huaweicloud_ecs_scheduler.sh
```
PATH_ECS : Path of the folder scripts
```

## Description

The Shell Scripts allows to Start, Stop an List all the ECS in a particular Project. Also, you can Schedule the Start and Stop operations to be executed through Crontab.

![image](https://user-images.githubusercontent.com/46529218/186489835-0f960cd8-5a2e-4f3a-94c2-3f9326c4bdef.png)

Note: Successfully tested on Ubuntu 18.04 with OpenStack Client 5.2.2

## Execution

```
sh huaweicloud_ecs_scheduler.sh
```

Enjoy!
