provider "aws" {
  region = "ap-southeast-1"

}

resource "aws_instance" "firstec2" {
  ami                    = "ami-0d058fe428540cd89"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.firstec2.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busy­box ht­tpd -f -p 8080 &
              EOF

  tags = { Name = "terraform Example" }
}

resource "aws_security_group" "firstec2" {
  name = "terraform-firstec2-sg"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}