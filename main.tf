provider "aws" {
  region = "us-west-1"
 
}

resource "aws_instance" "c8" {
  ami           = "ami-080d1454ad4fabd12"
  instance_type = "t2.micro"

  tags = {
    Name = "c8.local"
  }
user_data     = <<-EOF
                 #!/bin/bash
                 sudo hostnamectl set-hostname c8.local
                 EOF
}


resource "aws_instance" "u21" {
  ami           = "ami-0da7657fe73215c0c"
  instance_type = "t2.micro"

  tags = {
    Name = "u21.local"
  }

 user_data     = <<-EOF
                 #!/bin/bash
                 sudo hostnamectl set-hostname u21.local
                 EOF


}


resource "local_file" "file_01" {
  filename = "inventory.txt"
content = "[frontend]\n${aws_instance.c8.private_ip}\n[backend]\n${aws_instance.u21.private_ip}"

}
