#!/bin/bash

BOX_ADDRESS=178.128.245.166
BOX_USER=root
BOX_BECOME_PASS=

set -e

BOX_PLAYBOOK=$PWD/boxes/box_bootstrap_only.yml
BOX_NAME=${BOX_NAME-WP}
BOX_ADDRESS=${BOX_ADDRESS-192.168.2.66}
BOX_USER=${BOX_USER-slavko}
BOX_PWD=${BOX_PWD-}
BOX_BECOME_PASS=${BOX_BECOME_PASS-}
BOX_TAGS=${BOX_TAGS}

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
provision $BOX_NAME $BOX_TAGS
unregister $BOX_NAME
EOF

