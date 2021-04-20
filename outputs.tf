output "manager_ips" {
  value       = [module.managers.ipv4_addresses]
  description = "The manager nodes public ipv4 adresses"
}

output "manager_ips_private" {
  value       = [module.managers.ipv4_addresses_private]
  description = "The manager nodes private ipv4 adresses"
}

output "worker_ips" {
  value       = [module.workers.ipv4_addresses]
  description = "The worker nodes public ipv4 adresses"
}

output "worker_ips_private" {
  value       = [module.workers.ipv4_addresses_private]
  description = "The worker nodes private ipv4 adresses"
}

output "droplet_ids" {
  value       = concat(module.managers.droplet_ids, module.workers.droplet_ids)
  description = "List containing the ids of all droplets"
}

output "droplet_urns" {
  value       = concat(module.managers.droplet_urns, module.workers.droplet_urns)
  description = "List containing the uniform resource name (URN) of all droplets"
}

output "manager_token" {
  value       = module.managers.manager_token
  description = "The Docker Swarm manager join token"
  sensitive   = true
}

output "worker_token" {
  value       = module.managers.worker_token
  description = "The Docker Swarm worker join token"
  sensitive   = true
}

