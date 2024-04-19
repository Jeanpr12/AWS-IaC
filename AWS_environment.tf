terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.43.0"
    }
  }
}

variable "access_key_var" {
  
}

variable "secret_key_var" {
  
}


#Authentication




provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key_var
  secret_key = var.secret_key_var

}







                                                                    # Web Server Project #



                                              #This is a real demonstration of the deployment of a Web Server in AWS"







#VPC(Network)
resource "aws_vpc" "Sandbox" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "test-project"
  }
}





#Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.Sandbox.id

  tags = {
    Name = "router"
  }
}





#route table
resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.Sandbox.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

 
  tags = {
    Name = "Production"
  }
}





#subent for web server
resource "aws_subnet" "VLAN1" {
  vpc_id     = aws_vpc.Sandbox.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "VLAN-prod"
  }
}





#associate route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.VLAN1.id
  route_table_id = aws_route_table.route-table.id
}





#ACL
resource "aws_default_security_group" "firewall" {
  vpc_id = aws_vpc.Sandbox.id
  
  ingress {
    description = "HHTPS traffic"
    protocol  = "tcp"
    self      = true
    from_port = 443
    to_port   = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    description = "HHTP traffic"
    protocol  = "tcp"
    self      = true
    from_port = 80
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    description = "SSH traffic"
    protocol  = "tcp"
    self      = true
    from_port = 22
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}





#network interface(pricate IP of the server)
resource "aws_network_interface" "NIC-interface" {
  subnet_id       = aws_subnet.VLAN1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_default_security_group.firewall.id]
}







#Elastic IPs are free under certain conditions that cannot be met at this moment. For the purpose of this project enable the following block for testing only:

#elastic IP (Public IP of the server)
# resource "aws_eip" "public-ip" {
#   vpc                       = true
#   network_interface         = aws_network_interface.NIC-interface.id
#   associate_with_private_ip = "10.0.1.50" 
# }





#Web server EC2
# resource "aws_instance" "web-server" {
#   ami           = "ami-080e1f13689e07408"
#   instance_type = "t2.micro"
#   availability_zone = "us-east-1a"
#   key_name =  "Main-Key-Project"

#   network_interface {
    
#     device_index = 0
#     network_interface_id = aws_network_interface.NIC-interface.id

#   }

#   user_data = <<-EOF
#           #!bin/bash
#           sudo apt-update -y
#           sudo apt install apache2 -y
#           sudo systemctl start apache2
#           EOF

#   tags = {
#     Name = "Server"
#   }

# }
