# security group with ingress to port 80 and 22 open to home address
resource "aws_security_group" "fib_sg" {
  name        = "SG for fib instance"
  description = "Allow 80 and 22 inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.fib.id

  tags = local.tags
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_home_ipv4" {
  security_group_id = aws_security_group.fib_sg.id
  cidr_ipv4         = local.home_cidr
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_home_ipv4" {
  security_group_id = aws_security_group.fib_sg.id
  cidr_ipv4         = local.home_cidr
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Open to the public so Pebblepost can evaluate. This can be replaced with  office CIDR if they use a VPN
resource "aws_vpc_security_group_ingress_rule" "allow_http_internet_ipv4" {
  security_group_id = aws_security_group.fib_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_internet_ipv4" {
  security_group_id = aws_security_group.fib_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.fib_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}