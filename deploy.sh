#!/bin/bash

INVENTORY=staging

sudo ansible-galaxy install -r requirements.yaml

ansible-playbook playbook.yaml -i ${INVENTORY}
