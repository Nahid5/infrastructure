terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.19.1"
    }
  }
}

# Configure the Linode Provider
provider "linode" {
  token = ""
}

resource "linode_sshkey" "foo" {
  label = "foo"
  ssh_key = chomp(file("~/.ssh/id_rsa.pub"))
}


# Create a Linode
resource "linode_instance" "web" {
    label = "VPN"
    image = "linode/ubuntu20.04"
    region = "us-east"
    type = "g6-standard-1"
    authorized_keys = [linode_sshkey.foo.ssh_key]
    root_pass = "terr4form-test"

    group = "VPN"
    tags = [ "VPN" ]
    swap_size = 256
    private_ip = false
}