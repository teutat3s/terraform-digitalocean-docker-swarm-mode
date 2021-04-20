resource "digitalocean_droplet" "worker" {
  count              = var.total_instances
  name = format(
    "%s-%02d.%s.%s",
    var.name,
    count.index + 1,
    var.region,
    var.domain,
  )
  image              = var.image
  size               = var.size
  region             = var.region
  ssh_keys           = var.ssh_keys
  private_networking = true
  backups            = var.backups
  ipv6               = false
  tags               = var.tags
  user_data          = var.user_data

  connection {
    type        = "ssh"
    host        = self.ipv4_address
    user        = "root"
  }

  provisioner "remote-exec" {
    inline = [
      "docker swarm join --token ${var.join_token} ${var.manager_private_ip}",
    ]
  }

  provisioner "remote-exec" {
    when = destroy

    inline = [
      "timeout 25 docker swarm leave --force",
    ]

    on_failure = continue
  }
}

