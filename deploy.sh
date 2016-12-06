#!/bin/bash

INVENTORY=staging
#PLAYBOOKS+=(filestorage.yaml)
#PLAYBOOKS+=(loadbalancer.yaml)
#PLAYBOOKS+=(postgresql.yaml)
#PLAYBOOKS+=(rabbitmq.yaml)
#PLAYBOOKS+=(redis.yaml)
PLAYBOOKS+=(documentservers.yaml)

sudo ansible-galaxy install -r requirements.yaml

for i in ${PLAYBOOKS[@]};
do
  ansible-playbook ${i} -i ${INVENTORY}
done
