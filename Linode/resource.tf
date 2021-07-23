resource "linode_sshkey" "dev" {
  label = "dev"
  ssh_key = chomp(file("~/.ssh/id_rsa.pub"))
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