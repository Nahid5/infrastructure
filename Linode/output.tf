# Get public IP of VPN server
output "vpn_url" {  
    description = "URL of load VPN"  
    value       = "${resource.linode_instance.vpn.ip_address}"
}