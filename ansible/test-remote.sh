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

    `basename $0` [IP] [SSH_PORT] [SSH_USER] [SYSTEM] [PLAYBOOK]

Examples:

    `basename $0` 10.0.1.200 22 nix nixos k3s
    `basename $0` 10.0.1.200 22 arch archlinux k3s
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
SYSTEM=$4
PLAYBOOK=$5
[ -z "$IP" ] && error "Invalid arguments"
[ "$IP" = "-h" ] && usage 0
[ "$IP" = "--help" ] && usage 0
[ "$IP" = "help" ] && usage 0
[ -z "$(echo "$IP" | awk '/^([0-9]{1,3}[.]){3}([0-9]{1,3})$/{print $1}')" ] && error "Invalid IP"
[ -z "$PORT" ] && error "Invalid Port"
[ -z "$USER" ] && error "Invalid User"
[ -z "$SYSTEM" ] && error "Invalid System"
[ -z "$PLAYBOOK" ] && error "Invalid Playbook"

echo "Ping $IP..."
ping -c 1 -W 2 $IP >/dev/null || error "Device not found!"

tmp_dir=$(mktemp -d)

close() {
    if [ -e ${tmp_dir}/ansible.pub ]; then
        local pubKeyString="$(awk '{print $2}' ${tmp_dir}/ansible.pub)"
        ssh -o 'UserKnownHostsFile=/dev/null' -o 'StrictHostKeyChecking=no' -o 'PasswordAuthentication=no' -i ${tmp_dir}/ansible -p $PORT $USER@${IP} \
            'if test -f $HOME/.ssh/authorized_keys; then if grep -v "'${pubKeyString}'" $HOME/.ssh/authorized_keys > $HOME/.ssh/tmp; then cat $HOME/.ssh/tmp > $HOME/.ssh/authorized_keys && rm $HOME/.ssh/tmp; else rm $HOME/.ssh/authorized_keys && rm $HOME/.ssh/tmp; fi; fi' >/dev/null 2>&1
    fi

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
[$SYSTEM]
$SYSTEM-01 ansible_host=${IP} ansible_user=$USER ansible_connection=ssh ansible_port=$PORT ansible_ssh_private_key_file=${tmp_dir}/ansible
EOL

ansible-playbook \
    -K \
    --ask-vault-password \
    -i ${tmp_dir}/inventory \
    ./playbooks/$PLAYBOOK.yaml

[ $? -ne 0 ] && error "Playbook FAILED"

echo -e "${GREEN}OK: Playbook test successful${NC}"
