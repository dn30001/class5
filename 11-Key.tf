resource "tls_private_key" "MyLinuxBox" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

data "tls_public_key" "MyLinuxBox" {
  private_key_pem = tls_private_key.MyLinuxBox.private_key_pem
}

output "private_key" {
  value     = tls_private_key.MyLinuxBox.private_key_pem
  sensitive = true
}

output "public_key" {
  value = data.tls_public_key.MyLinuxBox.public_key_openssh
}

# Write private key to a TXT file
resource "local_file" "private_key_txt_file" {
  content  = tls_private_key.MyLinuxBox.private_key_pem
  filename = "MyLinuxBox.txt"
}

# Write public key to a TXT file
resource "local_file" "public_key_txt_file" {
  content  = data.tls_public_key.MyLinuxBox.public_key_openssh
  filename = "MyLinuxBox.txt"
}

# Write private key to a PEM file
resource "local_file" "private_key_pem_file" {
  content  = tls_private_key.MyLinuxBox.private_key_pem
  filename = "MyLinuxBox.pem"
}
