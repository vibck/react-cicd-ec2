provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "react_ec2" {
  ami           = "ami-07eef52105e8a2059" 
  instance_type = "t2.micro"
  key_name      = "universal"
  security_groups = [aws_security_group.react_sg.name]

  tags = {
    Name = "React-EC2"
  }
}

resource "aws_security_group" "react_sg" {
  name        = "react-security-group"
  description = "Erlaubt HTTP und SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

output "public_ip" {
  value = aws_instance.react_ec2.public_ip
}
