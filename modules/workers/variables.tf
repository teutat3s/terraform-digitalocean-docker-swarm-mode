variable "domain" {
  description = "Domain name used in droplet hostnames, e.g example.com"
  type        = string
}

variable "join_token" {
  description = "Join token for the nodes"
  type        = string
}

variable "manager_private_ip" {
  description = "Private ip adress of a manager node, used to have a node join the existing cluster"
  type        = list(string)
}

variable "ssh_keys" {
  description = "A list of SSH IDs or fingerprints to enable in the format [12345, 123456] that are added to worker nodes"
  type        = list(string)
}

variable "region" {
  description = "Datacenter region in which the cluster will be created"
  default     = "ams3"
  type        = string
}

variable "total_instances" {
  description = "Total number of instances of this type in cluster"
  default     = 1
  type        = number
}

variable "image" {
  description = "Operating system for the worker nodes"
  default     = "docker-20-04"
  type        = string
}

variable "size" {
  description = "Droplet size of worker nodes"
  default     = "s-1vcpu-1gb"
  type        = string
}

variable "backups" {
  default     = false
  description = "Enable backups of the worker nodes"
  type        = bool
}

variable "name" {
  description = "Prefix for name of worker nodes"
  default     = "worker"
  type        = string
}

variable "user_data" {
  description = "User data content for worker nodes. Use this for installing a configuration management tool, such as Puppet or installing Docker"

  default = <<EOF
  #!/bin/sh
EOF

  type        = string
}

variable "tags" {
  description = "List of DigitalOcean tag ids"
  default     = []
  type        = list(string)
}
