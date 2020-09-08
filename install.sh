#!/bin/bash
ansible-playbook play.yml -i servers
sleep 9
ansible-playbook play-sentinel.yml -i servers
sleep 5
ansible-playbook play-haproxy.yml -i servers
