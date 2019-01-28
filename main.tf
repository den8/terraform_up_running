provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami = "ami-40d28157"
  instance_type = "t2.micro"

  user_data = <<-EOF
    #! /bin/bash
    echo "hello world!!" > index.html
    nohup busybox httpd -f -p 8080 &
    EOF

  tags {
    Name = "terraform-example"
  }
}
