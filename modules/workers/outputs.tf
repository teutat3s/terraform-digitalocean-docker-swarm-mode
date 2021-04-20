output "ipv4_addresses" {
  value       = [digitalocean_droplet.worker.*.ipv4_address]
  description = "The workers public ipv4 adresses"
}

output "ipv4_addresses_private" {
  value       = [digitalocean_droplet.worker.*.ipv4_address_private]
  description = "The workers private ipv4 adresses"
}

output "droplet_ids" {
  value       = [digitalocean_droplet.worker.*.id]
  description = "The droplet ids"
}

output "droplet_hostnames" {
  value       = [digitalocean_droplet.worker.*.name]
  description = "The droplet names"
}

