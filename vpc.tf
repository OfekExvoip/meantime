
resource "aws_vpc" "examplevpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "pbx-vpc"
  }

  enable_dns_hostnames = true
}

resource "aws_subnet" "examplesub1" {
  depends_on = [
    aws_vpc.examplevpc,
  ]

  vpc_id     = "${aws_vpc.examplevpc.id}"
  cidr_block = "10.0.1.0/24"

  availability_zone_id = "${var.region}-az1"

  tags = {
    Name = "examplesub1"
  }

  map_public_ip_on_launch = true
}

resource "aws_subnet" "examplesub2" {
  depends_on = [
    aws_vpc.examplevpc,
  ]

  vpc_id     = "${aws_vpc.examplevpc.id}"
  cidr_block = "10.0.2.0/24"

  availability_zone_id = "${var.region}-az2"

  tags = {
    Name = "examplesub2"
  }

  map_public_ip_on_launch = true
}


resource "aws_internet_gateway" "exampleigw" {
  depends_on = [
    aws_vpc.examplevpc,
  ]


  vpc_id = "${aws_vpc.examplevpc.id}"

  tags = {
    Name = "exampleigw"
  }
}

resource "aws_route_table" "examplert" {
  depends_on = [
    aws_vpc.examplevpc,
    aws_internet_gateway.exampleigw,
  ]

  vpc_id = "${aws_vpc.examplevpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.exampleigw.id}"
  }

  

  tags = {
    Name = "examplert"
  }
}

resource "aws_route_table_association" "associateRouteTableWithSubnet1" {
  depends_on = [
    aws_subnet.examplesub1,
    aws_route_table.examplert,
  ]
  subnet_id      = aws_subnet.examplesub1.id
  route_table_id = aws_route_table.examplert.id
}


resource "aws_route_table_association" "associateRouteTableWithSubnet2" {
  depends_on = [
    aws_subnet.examplesub1,
    aws_route_table.examplert,
  ]
  subnet_id      = aws_subnet.examplesub2.id
  route_table_id = aws_route_table.examplert.id
}



resource "aws_security_group" "examplesg" {
  depends_on = [
    aws_vpc.examplevpc,
  ]
  vpc_id = aws_vpc.examplevpc.id
  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 5060
    to_port     = 5060
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5160
    to_port     = 5160
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5061
    to_port     = 5061
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8088
    to_port     = 8088
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 85
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 10000
    to_port     = 12000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 10000
    to_port     = 12000
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8001
    to_port     = 8001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1443
    to_port     = 1443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8089
    to_port     = 8089
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8003
    to_port     = 8003
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "pbxsg"
  }

  
}


