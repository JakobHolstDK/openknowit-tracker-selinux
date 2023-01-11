#!/usr/bin/env bash
MYSECRET=""
MYIP=`ip a |grep inet|grep "172."|awk '{print $2 }'| awk -F'/' '{print $1 }'` 

vault kv put "dnsinabox/services/openknowit.com/ku-selinux" type="A" ipv4="${MYIP}"
vault kv put "dnsinabox/services/traeckle.com/ku-selinux" type="A" ipv4="${MYIP}"

MYSECRET=`vault kv get "openknowit/tracker/selinux/${HOSTNAME}"  | jq .data.data.secretkey`
if [[ $MYSECRET == "" ]];
then
    python3 -m venv /tmp/venvdjang
    source /tmp/venvdjang/bin/activate
    pip install django
    MYSECRET=`python3 -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())'`
    vault kv put "openknowit/tracker/selinux/${HOSTNAME}"  secretkey=$MYSECRET
    rm -fr /tmp/venvdjang
fi


OLDKEY=`grep "SECRET_KEY = " openknowitselinuxttracker/openknowitselinuxttracker/settings.py  | awk -F"'" '{ print $2 }'`
echo $OLDKEY
echo $MYSECRET
sed -i "s/SECRET_KEY = +/SECRET_KEY = \'${MYSECRET}\'/" openknowitselinuxttracker/openknowitselinuxttracker/settings.py

grep $MYSECRET  openknowitselinuxttracker/openknowitselinuxttracker/settings.py
if [[ $? == 0 ]];
then    
    echo "`date`: secret is set"
    exit 0
else
    echo "`date`: secret wrong"
fi