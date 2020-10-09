#!/bin/bash

INVENTORY=staging

ansible --version foo >/dev/null 2>&1 || { echo >&2 "Make sure that Ansible has been installed.  Aborting."; exit 1; }

sudo ansible-galaxy install -r requirements.yaml

ansible-playbook play_rabbitmq.yml -i ${INVENTORY}

ansible-playbook play_postgresql.yml -i ${INVENTORY}

ansible-playbook playbook.yaml -i ${INVENTORY}
