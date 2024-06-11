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
