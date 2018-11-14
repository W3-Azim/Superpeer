# Automated Deployment

Requirements:
- `ansible 2.7.0`
- `testsuperpeer{1,2,3}rightmeshio.pem` keys have been added to the SSH authentication agent
    - You can do this via `ssh-add`, e.g. `ssh-add testsuperpeer1rightmeshio.pem`

## Directory Structure

```
deploy
    |
    |-- docker          # docker image definitions
    |   -- parity
    |   -- superPeer
    |   -- vizSuperPeer
    |-- roles           # remote machine roles (currently just base dependencies)
    |   -- base
    |-- playbook.yml    # ansible definition entrypoint
    |-- Vagrantfile     # local VM testing definition
    |-- hosts.yml       # remote / local env variables
```

## Building
Run `cd docker && make` 

This will generate a new Superpeer binary via gradle and copy it to each docker folder so that the
docker image building process has it in [context](https://docs.docker.com/engine/reference/commandline/build/#extended-description) to install independently.

`make` recurs into each docker directory building the associated `Dockerfile` and cleaning up (`rm`'ing) copied binaries.

Finally the built docker images are output as `tar` files in `docker/images` so that they can be copied to remote hosts and imported for use. Image output, copy, and install will go away with the completion of this ticket: [RM-1101](https://projects.leftofthedot.com:8443/browse/RM-1101).

## Deploying

#### Locally with a Vagrant VM
1. `vagrant up`
2. `ansible-playbook  -i hosts.yml -l localhost playbook.yml`

#### Remotely to AWS instances
1. `ansible-playbook -i hosts.yml -l aws playbook.yml`


## Troubleshooting
Ansible deployments are declarative in nature which makes them generally quite readable yet opaque.

To get better visibility into what ansible is actually doing you can append the `v` switch to the `ansible-playbook` command to get detailed output related to the steps ansible is trying to complete. See [here](https://docs.ansible.com/ansible/2.4/ansible-playbook.html#cmdoption-ansible-playbook-v) for more details.




     