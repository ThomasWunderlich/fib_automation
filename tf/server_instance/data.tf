data "aws_ami" "amazon_linux_2023" {
 most_recent = true

 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }

 filter {
   name   = "name"
   values = ["al2023-ami-*"]
 }
}

# Use data to grab the vpc from networking. You could also use the output from the tfstate.
# I prefer data since you're looking up what's actually there so if changes are made outside of tf you'll catch it.
data "aws_vpc" "fib" {
  tags = {
    Service = "Fibonacci"
  }
}

data "aws_subnet" "public_us_east_1a" {
  tags = {
    Name = "fibbonaci-public-us-east-1a"
  }
}