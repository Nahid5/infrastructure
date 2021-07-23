terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.19.1"
    }
  }
}

resource "linode_sshkey" "dev" {
  label = "dev"
  ssh_key = chomp(file("~/.ssh/id_rsa.pub"))
}

variable "INBOUNDIP" {
  type = string
}

variable "TOKEN" {
  type = string
}

provider "linode" {
  token = "${var.TOKEN}"
}


# Allow all inbound from lab and deny from anywhere else
resource "linode_firewall" "my_firewall" {
  label = "my_firewall"
  tags  = ["lab_firewall"]

  inbound {
    label    = "allow-all-lab"
    action   = "ACCEPT"
    protocol = "TCP"
    ipv4     = ["${var.INBOUNDIP}"]
  }

  inbound {
    label    = "allow-all-lab"
    action   = "ACCEPT"
    protocol = "UDP"
    ipv4     = ["${var.INBOUNDIP}"]
  }

  inbound {
    label    = "allow-all-lab"
    action   = "ACCEPT"
    protocol = "ICMP"
    ipv4     = ["${var.INBOUNDIP}"]
  }
  inbound_policy = "DROP"

  outbound_policy = "ACCEPT"

  linodes = [linode_instance.vpn.id]
}


/*Types
 1 - g6-nanode-1 : 1GB Nanode (1 vCPU):
 2 - g6-standard-1 : 2GB Linode (1 vCPU)
 3 - g6-standard-2 : 4GB Linode (2 vCPUs)
 4 - g6-standard-4
 5 - g6-standard-6
 6 - g6-standard-8
 7 - g6-standard-16
 8 - g6-standard-20
 9 - g6-standard-24
 10 - g6-standard-32
 11 - g7-highmem-1
 12 - g7-highmem-2
 13 - g7-highmem-4
 14 - g7-highmem-8
 15 - g7-highmem-16 : 300GB High Memory Linode (16 vCPUs)
 16 - g6-dedicated-2
 17 - g6-dedicated-4
 18 - g6-dedicated-8
 19 - g6-dedicated-16
 20 - g6-dedicated-32
 21 - g6-dedicated-48
 22 - g6-dedicated-50
 23 - g6-dedicated-56
 24 - g6-dedicated-64
 25 - g1-gpu-rtx6000-1
 26 - g1-gpu-rtx6000-2
 27 - g1-gpu-rtx6000-3
 28 - g1-gpu-rtx6000-4
 */

# Create a Linode
resource "linode_instance" "vpn" {
    label = "VPN"
    image = "linode/ubuntu20.04"
    region = "us-southeast"  #https://api.linode.com/v4/regions
    type = "g6-nanode-1"
    authorized_keys = [linode_sshkey.dev.ssh_key]
    root_pass = "terr4form-test"

    group = "VPN"
    tags = [ "VPN" ]
    private_ip = false
}

# Get public IP of VPN server
output "vpn_url" {  
    description = "URL of load VPN"  
    value       = "${resource.linode_instance.vpn.ip_address}"
}