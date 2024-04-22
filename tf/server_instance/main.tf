locals {

  home_cidr = "71.190.229.42/32"

    tags = {
    Terraform = "true"
    Environment = "dev"
      Service = "Fibonacci"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGBOmxQmOMtCfNwNnA7yJbiJJN8eWz4T1jH45d7R6ui twunde@gmail.com"
}

# For this takehome we're creating a public IP'd instance. Normally I'd create an autoscaling instance group using a
# pre-baked AMI via Packer and place it behind a load balancer.
# This has no IAM permissions, since I'm using DockerHub. ECR would require pull permissions
resource "aws_instance" "fib" {
  ami                         = "${data.aws_ami.amazon_linux_2023.id}"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = "deployer-key"
  vpc_security_group_ids      = ["${aws_security_group.fib_sg.id}"]
  subnet_id = data.aws_subnet.public_us_east_1a.id
  user_data = file("setup_fib.sh")
  user_data_replace_on_change = true
}



