provider "aws" {
  region = "us-east-1"
  profile = "devops-tf"
}

resource "aws_iam_user" "demo" {
  name = "mangesh"

}

resource "aws_iam_user" "demo1" {
  name = "omkar"
}

resource "aws_iam_user" "demo2" {
  name = "aniket"
}

resource "aws_iam_group" "grp" {
  name = "devops-b34"
}

resource "aws_iam_user_group_membership" "grpadd" {
   user = aws_iam_user.demo1.name

   groups = [
          aws_iam_group.grp.name
         ]
}
resource "aws_iam_user_group_membership" "grpadd2" {
   user = aws_iam_user.demo2.name

   groups = [
          aws_iam_group.grp.name
         ]
}
resource "aws_iam_user_group_membership" "grpadd3" {
   user = aws_iam_user.demo.name
   groups = [
         aws_iam_group.grp.name
       ]
}

resource "aws_security_group" "sg" {
    name = "sagar-sg"
    description = "test sg"
    vpc_id = "vpc-09eda2ae14df10c4e"


ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

}

egress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_instance" "vm" {
ami = "ami-08a0d1e16fc3f61ea"
instance_type = "t2.micro"
security_groups = [aws_security_group.sg.name]

tags = {
    Name = "DemoInstance"
}
}


output "instance_id" {
    description = "the id of instance"
    value = aws_instance.vm.id
}

output "instance_public_ip" {
    description = "print public ip"
    value = aws_instance.vm.public_ip
}

