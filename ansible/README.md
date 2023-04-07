# Ansible

Ansible playbooks to configure my systems.

## Usage

### Install Ansible dependencies

```bash
ansible-galaxy install -r requirements.yml
```

### SSH Key login

```bash
ssh-keygen -a 100 -t ed25519 -f ~/.ssh/$KEYNAME -N "" -C ""
ssh-copy-id -i ~/.ssh/$KEYNAME.pub USER@SERVER_IP
```

### Store Passwords

```bash
ansible-vault create ./playbooks/host_vars/$INVENTORY_HOSTNAME/secret.yml
ansible-vault edit ./playbooks/host_vars/$INVENTORY_HOSTNAME/secret.yml
```

## Run Playbook

```bash
ansible-playbook -i ./inventory/$INVENTORY_FILE -K --ask-vault-pass playbooks/$PLAYBOOK_FILE
```
