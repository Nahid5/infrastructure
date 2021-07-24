# Get public IP of VPN server
output "vpn_url" {  
    description = "URL of load VPN"  
    value       = "${digitalocean_droplet.vpn.ipv4_address}"
}