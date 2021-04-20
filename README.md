# Terraform DigitalOcean Docker Swarm mode

Terraform module to provision a Docker Swarm mode cluster in a single availability zone on DigitalOcean, using a private network.

[![CircleCI](https://circleci.com/gh/thojkooi/terraform-digitalocean-docker-swarm-mode.svg?style=svg)](https://circleci.com/gh/thojkooi/terraform-digitalocean-docker-swarm-mode)

- [Requirements](#requirements)
- [Usage](#usage)
- [Examples](#examples)
- [Swarm set-up](#swarm-set-up)

## Requirements

- Terraform >= 0.13
- Digitalocean account / API token with write access
- SSH Keys added to your DigitalOcean account
- [jq](https://github.com/stedolan/jq)

## Usage

```hcl
module "swarm-cluster" {
  source           = "github.com/teutat3s/terraform-digitalocean-docker-swarm-mode"

  total_managers    = 3
  total_workers     = 2
  region            = "fra1"
  domain            = "swarm.example.com"

  ssh_keys = [1234, 1235, ...]

  manager_image     = var.do_image
  worker_image      = var.do_image
  manager_size      = var.do_size
  worker_size       = var.do_size
  manager_tags      = [digitalocean_tag.environment.id, digitalocean_tag.manager.id]
  worker_tags       = [digitalocean_tag.environment.id, digitalocean_tag.worker.id]
}
```

### SSH Key

Terraform uses an SSH key to connect to the created droplets in order to issue `docker swarm join` commands. By default this uses `~/.ssh/id_rsa`. If you wish to use a different key, you can modify this using the variable `provision_ssh_key`. You also need to ensure the public key is added to your DigitalOcean account and it's listed in the `ssh_keys` list.

> Note that for this to work, you need to open the Docker remote API port in both iptables (not necessary with default images) and the DigitalOcean cloud firewall.

## Notes

### Installing Docker

It module does not install Docker - this is left up to the user of this module. The default image used comes with Docker CE pre-installed. It's encouraged to provide your own image or use configuration management tooling to install Docker.

You can also install Docker using user data. See the [user-data example](#).

This module has been tested with Docker CE v18.06 and later. Earlier versions should work (v1.13 and up), but have not been tested.

### Supported OS

This module has been tested with Ubuntu Docker (`docker-20-04`), CoreOS, and CentOS 7.4 provided by DigitalOcean, but it should work with other distributions as well, as long as `Docker` and `sudo` packages are installed.

### Ports & Firewall

Ensure the following ports are open on the local firewall;

Port       | Description                       | Note
---------- | --------------------------------- | -------
`2377/TCP` | cluster management communications | Cluster
`7946/TCP` | Container network discovery       | Cluster
`7946/UDP` | Container network discovery       | Cluster
`4789/UDP` | Container overlay network         | Cluster
`2376/TCP` | Docker Remote API | Optionally, when exposing the Docker Remote API

For example, when using the Docker images provided by DigitalOcean, run the following command:

```bash
ufw allow 2377
ufw allow 7946
ufw allow 7946/udp
ufw allow 4789/udp
```

#### Cloud Firewall

Also set up firewall rules on DigitalOcean for the cluster, to ensure only cluster members can access the internal Swarm ports. You can use the [digitalocean-docker-swarm-firewall](https://github.com/thojkooi/terraform-digitalocean-docker-swarm-firewall) module for this. Look in the [firewall examples directory](https://github.com/thojkooi/terraform-digitalocean-docker-swarm-mode/tree/master/examples/firewall) for inspiration on how to do this.

## Examples

For examples, see the [examples directory](https://github.com/thojkooi/terraform-digitalocean-docker-swarm-mode/tree/master/examples).

## Swarm mode set-up

### Manager nodes

First a single Swarm mode manager is provisioned. This is the initial leader node. If you have additional manager nodes, these will be provisioned after this step. Once the manager nodes have been provisioned, Terraform will initialize the Swarm on the first manager node and retrieve the join tokens. It will then have all the managers join the cluster.

If the cluster is already up and running, Terraform will check with the first leader node to refresh the join tokens. It will join any additional manager nodes that are provisioned to the Swarm mode cluster.

### Worker nodes

Worker nodes should be used to run the Docker Swarm mode Services. By default, 2 worker nodes are provisioned. Set the number of desired worker nodes using the following variable: `total_workers`.

## License

This repository is forked from thojkooi/terraform-digitalocean-docker-swarm-mode

[MIT © Thomas Kooi](LICENSE)
