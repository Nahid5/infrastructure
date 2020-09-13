# Mail server for https://github.com/n0pe-sled/Postfix-Server-Setup
resource "digitalocean_droplet" "mail" {
  image = "ubuntu-16-04-x64"        #ubuntu-18-04-x64 ubuntu-20-04-x64
  name = "mail"
  region = "nyc1"                   #https://www.digitalocean.com/docs/networking/vpc/                                 
  size = "s-1vcpu-1gb"              #https://developers.digitalocean.com/documentation/changelog/api-v2/new-size-slugs-for-droplet-plan-changes/
  private_networking = true
  ssh_keys = [""]                   #Can add multiple ssh key names here. Get from DigitalOcean
  tags   = ["TEST1"]                #Add whatever tags you want
}

# VPN box
/* 
resource "digitalocean_droplet" "vpn" {
  image = "ubuntu-20-04-x64"        #ubuntu-18-04-x64 ubuntu-20-04-x64
  name = "vpn"
  region = "nyc1"                   #https://www.digitalocean.com/docs/networking/vpc/                                 
  size = "s-1vcpu-1gb"              #https://developers.digitalocean.com/documentation/changelog/api-v2/new-size-slugs-for-droplet-plan-changes/
  private_networking = true
  ssh_keys = [""]                   #Can add multiple ssh key names here. Get from DigitalOcean
  tags   = ["TEST1"]                #Add whatever tags you want
} 
*/