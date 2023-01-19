
resource "aws_vpc" "main" {
    # this is the cdr block for the vpc
    cidr_block = "10.0.0.0/16"

    enable_dns_support = true

    enable_dns_hostnames = true
    # gives the instance shared ability on the host
    instance_tenancy = "default"

    assign_generated_ipv6_cidr_block = false

    tags = {
        name = "main"
    }
  
}