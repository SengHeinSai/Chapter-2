provider "aws" {
  region = "ap-southeast-1"

}

resource "aws_instance" "firstec2" {
  ami                    = "ami-0f9d733050c9f5365"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.firstec2.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busy­box ht­tpd -f -p ${var.server_port} &
              EOF

  tags = { Name = "terraform Example" }
}

resource "aws_security_group" "firstec2" {
  name = "terraform-firstec2-sg"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "server_port" {
  description = "The port the server will use for HTTP re­quests"
  type        = number
  default     = 8080
}
output "public_ip" {
  value       = aws_instance.firstec2.public_ip
  description = "The pub­lic IP ad­dress of the web server"
}