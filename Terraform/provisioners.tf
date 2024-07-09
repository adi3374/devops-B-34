
resource "aws_key_pair" "dev-key" {
  key_name   = "dev-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXIJx+GLbGJ7ydhZhZydM4XmUVhcjTndl7npjEfuoepuGhlCNxrusbkRVCHwnfGQbsqLnlMZ7obbvRyL3aAjTeNfKK83l7laQoBBw3j4PBAS9ESDChtMwykpx5Dt95lLe/5JmfUkGr2c3sC4GVXxTS44igczXbkuzvRKxPUgkHTfF7t1JZ3bJEHbVFcalaSASDB1TgIhTmr2VLDSUPZuACZJC8W33/w5En4YHbwjTNGqfYyFd+iZk8WngdAlHWHMx1mdAiRZbXuOu/L00/2Ox5WjrAJ3KL9MApc+9E3hR9GrmGYcA/OWlFWI+fJ19aOi2Wzv93I45U9dWHMW5KECNAziC0ALHYSVYPdGUo+Ratv5oMLuzRFCUo17qUA7xlTKwAsNHDKYIh14hrIi/C2u5maXg6rqfuC4o3j/qoZsVeQz/ZHhcpHNkAG5oU/ss4XlMhha/QBHYpMuWcM4to1HFI35PzSq2TpB4XJHqOgYcjzZtc2T82y6duc8lnNFun2UM= abhipray@DESKTOP-7N6151H"
}

resource "aws_instance" "web" {
  ami           = "ami-01b799c439fd5516a"
  instance_type = "t2.micro"
  key_name      = "dev-key"
  
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    Name = "Prod"
  }



  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
    }
  }
}

resource "aws_security_group" "allow_ssh" {
  vpc_id = "vpc-0ea385724434c3818"
  name = "demo-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "instance_public_ip" {
  value = aws_instance.web.public_ip
}
