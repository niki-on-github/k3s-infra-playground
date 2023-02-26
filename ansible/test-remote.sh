#!/bin/bash

LBLUE='\033[1;34m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

usage() {
    cat <<EOF
Description:

    '`basename $0`' is a script to remote test the ansible playbook

Usage:

    `basename $0` [IP] [SSH_PORT] [SSH_USER]
EOF
    exit $1
}

error() {
    echo -e "${RED}ERROR: $1${NC}\n"
    exit 1
}

IP="$1"
PORT="$2"
USER="$3"
[ -z "$IP" ] && error "Invalid arguments"
[ "$IP" = "-h" ] && usage 0
[ "$IP" = "--help" ] && usage 0
[ "$IP" = "help" ] && usage 0
[ -z "$(echo "$IP" | awk '/^([0-9]{1,3}[.]){3}([0-9]{1,3})$/{print $1}')" ] && error "Invalid IP"
[ -z "$PORT" ] && error "Invalid Port"
[ -z "$USER" ] && error "Invalid User"

echo "Ping $IP..."
ping -c 1 -W 2 $IP >/dev/null || error "Device not found!"

tmp_dir=$(mktemp -d)

close() {
    rm -rf $tmp_dir
}
trap close SIGHUP SIGINT SIGTERM EXIT

echo "Remote Info: $USER@$IP:$PORT"
echo "Temp Directory: $tmp_dir"

ansible-galaxy install -r requirements.yml

set -e

ssh-keygen -a 100 -t ed25519 -f ${tmp_dir}/ansible -N "" -C ""
ssh-copy-id -o 'UserKnownHostsFile=/dev/null' -o 'StrictHostKeyChecking=no' -i ${tmp_dir}/ansible.pub -p $PORT $USER@${IP}

cat >${tmp_dir}/inventory <<EOL
[nixos]
nixos-01 ansible_host=${IP} ansible_user=$USER ansible_connection=ssh ansible_port=$PORT ansible_ssh_private_key_file=${tmp_dir}/ansible
EOL

ansible-playbook \
    -K \
    --ask-vault-password \
    -i ${tmp_dir}/inventory \
    ./playbooks/k3s.yml

[ $? -ne 0 ] && error "Playbook FAILED"

echo -e "${GREEN}OK: Playbook test successful${NC}"
