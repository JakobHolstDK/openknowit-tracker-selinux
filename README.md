This project will be shared as an opensource project 
Name to be decided

KNOWITSELINUXINFORMATIONMANAGER

Roles:
Collects and saves data locally to be used on the manager
   - src: git@git.ku.dk:ku-it/ansible/forsk/roles/selinux_agent.git
     scm: git
     version: "main"

Distributes data saved locally and ignites the digester as a systemd servive
   - src: git@git.ku.dk:ku-it/ansible/forsk/roles/selinux_manager.git
     scm: git
     version: "main"

Not implemented yet
   - src: git@git.ku.dk:ku-it/ansible/forsk/roles/selinux_db.git
     scm: git
     version: "main"

Used for both digesting and presenting the result as a web page
   - src: git@git.ku.dk:ku-it/ansible/forsk/roles/selinux_app.git
     scm: git
     version: "main"

Not implemented yet
   - src: git@git.ku.dk:ku-it/ansible/forsk/roles/selinux_web.git
     scm: git
     version: "main"usr/bin/env bash

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
  echo "`date`: running playbook on agents" #collect data
  ansible-playbook -i inventory  playbook.agents.yml
  echo "`date`: running playbook on manager" #sync data and start/restart the digester
  ansible-playbook -i inventory  playbook.manager.yml
  sleep 30
done


 http://selinuxapp01fl.unicph.domain/status/


