#!/bin/bash

BOX_ADDRESS=178.128.245.166
BOX_NAME=staging
BOX_USER=ubuntu
BOX_BECOME_PASS=

set -e

BOX_PLAYBOOK=$PWD/boxes/box_staging.yml
BOX_NAME=wordpress-staging
BOX_ADDRESS=${BOX_ADDRESS-192.168.2.66}
BOX_USER=${BOX_USER-slavko}
BOX_BECOME_PASS=${BOX_BECOME_PASS-}

# Register the new Prudentia box, provision it with the staging artifact and eventually unregisters the box
prudentia ssh <<EOF
unregister $BOX_NAME
register
$BOX_PLAYBOOK
$BOX_NAME
$BOX_ADDRESS
$BOX_USER
$BOX_PWD
verbose 2
set ansible_become_password ${BOX_BECOME_PASS}
set application_version ${VERSION-"0.0.1"}
provision $BOX_NAME update
unregister $BOX_NAME
EOF
