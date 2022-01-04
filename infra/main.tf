variable "awsprops" {
    type = map
    default = {
    region = "eu-central-1"
    vpc = "vpc-0229b5f1ffd1920b3"
    ami = "ami-0d527b8c289b4af7f"
    itype = "t2.micro"
    subnet = "subnet-086e3e114afd0d070"
    publicip = true
    keyname = "Symphony"
    secgroupname = "Symphony"
  }
}

provider "aws" {
  region = lookup(var.awsprops, "region")
  shared_credentials_file = "/home/stk/.aws/credentials"
  
}

resource "aws_security_group" "symphony" {
  name = lookup(var.awsprops, "secgroupname")
  description = lookup(var.awsprops, "secgroupname")
  vpc_id = lookup(var.awsprops, "vpc")

  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_instance" "symphony_instance" {
  ami = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  subnet_id = lookup(var.awsprops, "subnet") #FFXsubnet2
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = lookup(var.awsprops, "keyname")


  vpc_security_group_ids = [
    aws_security_group.symphony.id
  ]

  root_block_device {
    delete_on_termination = true
    volume_size = 8 
    volume_type = "gp2"
  }
  tags = {
    Name ="SERVER"
    Environment = "DEV"
    OS = "UBUNTU"
    Managed = "SYMPHONY"
  }

  depends_on = [ aws_security_group.symphony ]
  user_data = "${file("init.sh")}"
}

output "ec2instance_ip" {
  value = aws_instance.symphony_instance.public_ip
}

output "ec2instance_dns" {
  value = aws_instance.symphony_instance.public_dns
}
