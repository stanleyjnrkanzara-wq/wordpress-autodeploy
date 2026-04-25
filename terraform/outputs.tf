output "server_ip" {
  description = "Your WordPress server public IP"
  value       = aws_eip.wordpress.public_ip
}

output "ssh_command" {
  description = "Command to SSH into your server"
  value       = "ssh -i ~/wordpress-project/keys/wordpress-key.pem ubuntu@${aws_eip.wordpress.public_ip}"
}

output "wordpress_url" {
  description = "Your WordPress site URL"
  value       = "http://${aws_eip.wordpress.public_ip}"
}
