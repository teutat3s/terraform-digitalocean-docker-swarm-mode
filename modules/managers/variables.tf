variable "domain" {
  description = "Domain name used in droplet hostnames, e.g example.com"
  type        = string
}

variable "ssh_keys" {
  description = "A list of SSH IDs or fingerprints to enable in the format [12345, 123456] that are added to manager nodes"
  type        = list(string)
}

variable "region" {
  description = "Datacenter region in which the cluster will be created"
  default     = "ams3"
  type        = string
}

variable "total_instances" {
  description = "Total number of managers in cluster"
  default     = 1
  type        = number
}

variable "image" {
  description = "Droplet image used for the manager nodes"
  default     = "docker-20-04"
  type        = string
}

variable "size" {
  description = "Droplet size of manager nodes"
  default     = "s-1vcpu-1gb"
  type        = string
}

variable "name" {
  description = "Prefix for name of manager nodes"
  default     = "manager"
  type        = string
}

variable "backups" {
  description = "Enable DigitalOcean droplet backups"
  default     = false
  type        = bool
}

variable "user_data" {
  description = "User data content for manager nodes"

  default = <<EOF
  #!/bin/sh
EOF

  type    = string
}

variable "tags" {
  description = "List of DigitalOcean tag ids"
  default     = []
  type        = list(string)
}
