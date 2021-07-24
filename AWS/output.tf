# Get up address of newly created EC2
output "image_id" {
    value = "${aws_instance.vpn.public_ip}"
}
