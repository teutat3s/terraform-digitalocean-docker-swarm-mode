resource "digitalocean_droplet" "manager" {
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
      count.index == 0 ? "docker swarm init --advertise-addr ${self.ipv4_address_private} &>/dev/null" : "true",
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

data "external" "swarm_tokens" {
  program    = ["bash", "${path.module}/scripts/get-swarm-join-tokens.sh"]
  depends_on = [digitalocean_droplet.manager]

  query = {
    host        = element(digitalocean_droplet.manager.*.ipv4_address, 0)
    user        = "root"
  }
}

resource "null_resource" "join" {
  count = var.total_instances - 1

  connection {
    host = element(digitalocean_droplet.manager.*.ipv4_address, count.index + 1)
    type = "ssh"
    user = "root"
  }

  provisioner "remote-exec" {
    inline = [
      "docker swarm join --token ${data.external.swarm_tokens.result["manager"]} ${digitalocean_droplet.manager[0].ipv4_address_private}",
    ]
  }
}
