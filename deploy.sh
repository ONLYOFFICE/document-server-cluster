#!/bin/bash

INVENTORY=staging
#PLAYBOOKS+=(filestorage.yaml)
#PLAYBOOKS+=(loadbalancer.yaml)
#PLAYBOOKS+=(database.yaml)
#PLAYBOOKS+=(rabbitmq.yaml)
#PLAYBOOKS+=(redis.yaml)
PLAYBOOKS+=(documentservers.yaml)
PLAYBOOKS+=(documentserver-example.yaml)

sudo ansible-galaxy install -r requirements.yaml

for i in ${PLAYBOOKS[@]};
do
  ansible-playbook ${i} -i ${INVENTORY}
done
