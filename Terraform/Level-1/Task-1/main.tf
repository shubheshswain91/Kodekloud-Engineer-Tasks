# Generate a new private key using the RSA algorithm
resource "tls_private_key" "devops_key" {
  algorithm = "RSA"
}

# Create the AWS Key Pair using the generated public key
resource "aws_key_pair" "devops_kp" {
  key_name   = "devops-kp"
  public_key = tls_private_key.devops_key.public_key_openssh
}

# Save the private key to the specified local path
resource "local_file" "private_key_file" {
  content         = tls_private_key.devops_key.private_key_pem
  filename        = "/home/bob/devops-kp.pem"
  file_permission = "0400"
}


