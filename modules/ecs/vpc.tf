resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "pulbic-1" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = "10.0.1.0/24"
    availability_zone = "ap-south-1c"
    tags = {
        Name = "Main-1"
    }
}

resource "aws_subnet" "pulbic-2" {
    vpc_id     = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-south-1a"

    tags = {
        Name = "Main-2"
    }
}

