#!/bin/bash

INVENTORY=staging

ansible --version foo >/dev/null 2>&1 || { echo >&2 "Make sure that Ansible has been installed.  Aborting."; exit 1; }

ansible-galaxy install -r requirements.yaml

ansible -i ${INVENTORY} -m ping all
