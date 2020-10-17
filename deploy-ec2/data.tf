data "aws_ami" "ubuntu_latest" {
most_recent = true
owners = ["099720109477"]

  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

}
data "aws_subnet_ids" "public_subnets" {
  vpc_id = aws_vpc.default_ec2.id
 
  tags = {
    Tier = "public"
  }
}                    

data "aws_subnet_ids" "private_subnets" {
  vpc_id = aws_vpc.default_ec2.id
 
  tags = {
    Tier = "private"
  }
}   

# for_each      = data.aws_subnet_ids.public_subnets.ids
# subnet_id     = each.value
