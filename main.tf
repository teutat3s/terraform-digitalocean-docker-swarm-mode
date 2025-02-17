module "managers" {
  source = "./modules/managers"

  image  = var.manager_image
  size   = var.manager_size
  name   = var.manager_name
  region = var.region
  domain = var.domain

  total_instances = var.total_managers
  user_data       = var.manager_user_data
  tags            = var.manager_tags

  ssh_keys           = var.ssh_keys
}

module "workers" {
  source = "./modules/workers"

  image  = var.worker_image
  size   = var.worker_size
  name   = var.worker_name
  region = var.region
  domain = var.domain

  total_instances = var.total_workers
  user_data       = var.worker_user_data
  tags            = var.worker_tags

  manager_private_ip = element(module.managers.ipv4_addresses_private, 0)
  join_token         = module.managers.worker_token

  ssh_keys           = var.ssh_keys
}

