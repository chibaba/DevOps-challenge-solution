resource "aws_subnet" "public_subnet_1" {
    # instantiate vpc id
    vpc_id = aws_vpc.main.id

    # the cdr block fr the subnet
    cidr_block = "10.0.1.0/24"

    availability_zone = "us-east-1"

    map_public_ip_on_launch = true

    tags = {
        Name                    = "public-us-east-1a"
    }
  
}