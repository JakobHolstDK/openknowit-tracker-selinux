#!/usr/bin/env bash

echo "`date`: Resfrehing roles from git"
ansible-galaxy role install -fr roles/requirements.yml >/dev/null 2>&1
echo "`date`: install the selinux db"
ansible-playbook -i inventory  playbook.db.yml
echo "`date`: install the selinux app"
ansible-playbook -i inventory  playbook.app.yml


while [[ 1 == 1 ]];
do
  echo "`date`: Resfrehing roles from git"
  ansible-galaxy role install -fr roles/requirements.yml >/dev/null 2>&1
  echo "`date`: running playbook on agents"
  ansible-playbook -i inventory  playbook.agents.yml
  echo "`date`: running playbook on manager"
  ansible-playbook -i inventory  playbook.manager.yml
  sleep 30
done
