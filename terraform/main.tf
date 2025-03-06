provider "aws" {
  region = "eu-central-1"
}

# VPC erstellen
resource "aws_vpc" "react_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Subnetz erstellen
resource "aws_subnet" "react_subnet" {
  vpc_id                  = aws_vpc.react_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true
}

# EC2-Instanz erstellen
resource "aws_instance" "react_ec2" {
  ami           = "ami-07eef52105e8a2059" 
  instance_type = "t2.micro"
  key_name      = "universal"
  
  subnet_id     = aws_subnet.react_subnet.id
  vpc_security_group_ids = [aws_security_group.react_sg.id]  

  tags = {
    Name = "React-EC2"
  }
}

# Sicherheitsgruppe erstellen
resource "aws_security_group" "react_sg" {
  name        = "react-security-group-new"
  description = "Erlaubt HTTP, HTTPS und SSH"
  vpc_id      = aws_vpc.react_vpc.id

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

  ingress {
    from_port   = 3000
    to_port     = 3000
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

# Internet Gateway erstellen
resource "aws_internet_gateway" "react_igw" {
  vpc_id = aws_vpc.react_vpc.id

  tags = {
    Name = "React-IGW"
  }
}

# Route Table erstellen
resource "aws_route_table" "react_rt" {
  vpc_id = aws_vpc.react_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.react_igw.id
  }

  tags = {
    Name = "React-RT"
  }
}

# Route Table mit Subnet verbinden
resource "aws_route_table_association" "react_rta" {
  subnet_id      = aws_subnet.react_subnet.id
  route_table_id = aws_route_table.react_rt.id
}

# Output: öffentliche IP der EC2-Instanz
output "public_ip" {
  value = aws_instance.react_ec2.public_ip
}


