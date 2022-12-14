terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# create vpc resource
resource "aws_vpc" "mylab-vpc" {
    cidr_block = "172.20.0.0/16"

    tags = {
        Name = "mylab-vpc"
    }
}

# create subnets
resource "aws_subnet" "mylab-subnet-1" {
    vpc_id = aws_vpc.mylab-vpc.id 
    cidr_block = "172.20.10.0/24"
    
    tags = {
        Name = "mylab-subnet-1"
    }
}

resource "aws_subnet" "mylab-subnet-2" {
    vpc_id = aws_vpc.mylab-vpc.id
    cidr_block = "172.20.20.0/24"

    tags = {
        Name = "mylab-subnet-2"
    }
}

resource "aws_internet_gateway" "mylab-igw" {
    vpc_id = aws_vpc.mylab-vpc.id 

    tags = {
        Name = "mylab-igw"
    }
}

resource "aws_security_group" "mylab-sg" {
    name = "mylab-sg"
    description = "To allow inbound outbound traffic"
    vpc_id = aws_vpc.mylab-vpc.id 

    tags = {
        Name = "mylab-sg"
    }

    # Since Jenkins runs on port 8080, we are allowing all traffic from the internet
  # to be able ot access the EC2 instance on port 8080
  ingress {
    description = "Allow all traffic through port 8080"
    from_port = "8080"
    to_port = "8080"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# create route tables
resource "aws_route_table" "mylab-rtb" {
    vpc_id = aws_vpc.mylab-vpc.id 
  
    tags = {
        Name = "mylab-rtb"
      }
  
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.mylab-igw.id 
  
      }
   }
  
   resource "aws_route_table_association" "mylab-assn" {
     subnet_id = aws_subnet.mylab-subnet-1.id 
    # subnet_id = aws_subnet.mylab-subnet-2.id 
     route_table_id = aws_route_table.mylab-rtb.id 
   }
  # create Jenkins EC2 instance 
resource "aws_instance" "jenkins-server" {
  ami           = "ami-05fa00d4c63e32376"
  instance_type = "t2.micro"
  key_name = "gurpreet-key"
  vpc_security_group_ids = [aws_security_group.mylab-sg.id]
  subnet_id = aws_subnet.mylab-subnet-1.id
  associate_public_ip_address = true
  user_data = file("./install.sh")

  tags = {
    Name = "jenkins-server"
  }

}

 # create Ansible EC2 instance 
resource "aws_instance" "Ansible-server" {
  ami           = "ami-05fa00d4c63e32376"
  instance_type = "t2.micro"
  key_name = "gurpreet-key"
  vpc_security_group_ids = [aws_security_group.mylab-sg.id]
  subnet_id = aws_subnet.mylab-subnet-1.id
  associate_public_ip_address = true
  user_data = file("./installAnsible.sh")

  tags = {
    Name = "Ansible-server"
  }

}

 
 # create Docker EC2 instance 
resource "aws_instance" "Docker-server" {
  ami           = "ami-05fa00d4c63e32376"
  instance_type = "t2.micro"
  key_name = "gurpreet-key"
  vpc_security_group_ids = [aws_security_group.mylab-sg.id]
  subnet_id = aws_subnet.mylab-subnet-1.id
  associate_public_ip_address = true
  user_data = file("./installdocker.sh")

  tags = {
    Name = "Docker-server"
  }

}

 # create nexus EC2 instance 
resource "aws_instance" "nexus-server" {
  ami           = "ami-05fa00d4c63e32376"
  instance_type = "t2.medium"
  key_name = "gurpreet-key"
  vpc_security_group_ids = [aws_security_group.mylab-sg.id]
  subnet_id = aws_subnet.mylab-subnet-1.id
  associate_public_ip_address = true
  user_data = file("./installdocker.sh")

  tags = {
    Name = "nexus-server"
  }

}