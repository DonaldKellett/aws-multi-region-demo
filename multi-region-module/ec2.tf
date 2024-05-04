resource "aws_key_pair" "my-ssh-pubkey" {
  key_name   = "my-ssh-pubkey"
  public_key = file(pathexpand(var.ssh_pubkey_path))
}

resource "aws_instance" "my-ec2-instance" {
  ami                         = data.aws_ami.ubuntu.image_id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.my-ssh-pubkey.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.my-subnet.id
  security_groups             = [aws_security_group.my-sg.id]
}
