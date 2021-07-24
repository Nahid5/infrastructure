# Mail server for https://github.com/n0pe-sled/Postfix-Server-Setup
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

resource "digitalocean_ssh_key" "dev" {
  name        = "dev"
  public_key  = file("~/.ssh/id_rsa.pub")
}

resource "digitalocean_firewall" "vpn" {
  name = "allow-from-lab"

  droplet_ids = [digitalocean_droplet.vpn.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "1-65535"
    source_addresses = ["${var.INBOUNDIP}"]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "1-65535"
    source_addresses = ["${var.INBOUNDIP}"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["${var.INBOUNDIP}"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

# VPN box
resource "digitalocean_droplet" "vpn" {
  #project = "Something"
  image = "ubuntu-20-04-x64"        #ubuntu-18-04-x64 ubuntu-20-04-x64
  name = "vpn"
  region = "nyc1"                   #https://www.digitalocean.com/docs/networking/vpc/                                 
  size = "s-1vcpu-1gb"              #https://developers.digitalocean.com/documentation/changelog/api-v2/new-size-slugs-for-droplet-plan-changes/
  private_networking = true
  ssh_keys = [digitalocean_ssh_key.dev.fingerprint]                   #Can add multiple ssh key names here.
  tags   = ["TEST1"]                #Add whatever tags you want
}

