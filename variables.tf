variable "domain" {
  description = "Domain name used in droplet hostnames, e.g example.com"
  type        = string
}

variable "ssh_keys" {
  description = "A list of SSH IDs or fingerprints to enable in the format [12345, 123456] that are added to the provisioned nodes"
  type        = list(string)
}

variable "region" {
  description = "Datacenter region in which the cluster will be created"
  default     = "ams3"
  type        = string
}

variable "total_managers" {
  description = "Total number of managers in cluster"
  default     = 1
  type        = number
}

variable "total_workers" {
  description = "Total number of workers in cluster"
  default     = 1
  type        = number
}

variable "manager_image" {
  description = "Image for the manager nodes"
  default     = "docker-20-04"
  type        = string
}

variable "worker_image" {
  description = "Droplet image for the worker nodes"
  default     = "docker-20-04"
  type        = string
}

variable "manager_size" {
  description = "Droplet size of worker nodes"
  default     = "s-1vcpu-1gb"
  type        = string
}

variable "worker_size" {
  description = "Droplet size of worker nodes"
  default     = "s-1vcpu-1gb"
  type        = string
}

variable "manager_name" {
  description = "Prefix for name of manager nodes"
  default     = "manager"
  type        = string
}

variable "worker_name" {
  description = "Prefix for name of worker nodes"
  default     = "worker"
  type        = string
}

variable "manager_user_data" {
  description = "User data content for manager nodes. Use this for installing a configuration management tool, such as Puppet or installing Docker"

  default = <<EOF
  #!/bin/sh
EOF

  type        = string
}

variable "worker_user_data" {
  description = "User data content for worker nodes. Use this for installing a configuration management tool, such as Puppet or installing Docker"

  default = <<EOF
  #!/bin/sh
EOF

  type        = string
}

variable "manager_tags" {
  description = "List of DigitalOcean tag ids"
  default     = []
  type        = list(string)
}

variable "worker_tags" {
  description = "List of DigitalOcean tag ids"
  default     = []
  type        = list(string)
}
