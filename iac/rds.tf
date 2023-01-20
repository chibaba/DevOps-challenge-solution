
# RDS Postgres subnet group
resource "aws_db_subnet_group" "database-subnet-group" {
  name         = "database subnets"
  subnet_ids = [
      aws_subnet.private_1.id,
      aws_subnet.private_2.id,
      aws_subnet.private_3.id
    ]
  description  = "Subnets for Database Instance"

  tags   = {
    Name = "Database Subnets"
  }
}

# Postgres RDS instance
resource "aws_db_instance" "postgres" {

  provisioner "local-exec" {
    #command = "sed -i 's/spring.datasource.url.*/datasource.url=jdbc:postgresql://$DB_ADDR/$DB_NAME/'./DevOps-Challenge-main/jumia_phone_validator/validator-backend/src/resources/application.properties"
    command = "./replace.sh"
    environment = {
      DB_ADDR = self.endpoint
      DB_NAME = var.db_name
      DB_USERNAME = var.db_username
      DB_PASSWORD = var.db_password
    }
  }
  provisioner "local-exec" {
    command = "echo yes"
    working_dir = "./DevOps-Challenge-main/jumia_phone_validator/validator-backend/" 
  }
  provisioner "local-exec" {
    command = "mvn clean install"
    working_dir = "./DevOps-Challenge-main/jumia_phone_validator/validator-backend/" 
  }
  provisioner "local-exec" {
    command = "sudo docker build -t bashox/jumia-frontend"
    working_dir = "./DevOps-Challenge-main/jumia_phone_validator/validator-backend/" 
  }
  provisioner "local-exec" {
    command = "sudo docker push bashox/jumia-frontend"
    working_dir = "./DevOps-Challenge-main/jumia_phone_validator/validator-backend/" 
  }
  
  allocated_storage    = 10
  engine               = var.db_engine
  # engine_version       = "5.7"
  instance_class       = var.db_instance_class
  db_name               = var.db_name
  db_subnet_group_name = aws_db_subnet_group.database-subnet-group.name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = var.db_parameter_group
  skip_final_snapshot  = true
  vpc_security_group_ids  = [aws_security_group.allow-tcp.id]
}

#Postgres RDS security group

resource "aws_security_group" "allow-tcp" {
  name        = "allow-tcp-on-22-1337-5432"
  description = "Allow Tcp inbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "security group db"
  }
}

#Postgres RDS security group rule

resource "aws_security_group_rule" "db-security-group-rule-allow-22" {
  description              = "Allow port 22 nodes to communicate with control plane (all ports)"
  from_port                = 22
  protocol                 =  "tcp"
  security_group_id        = aws_security_group.allow-tcp.id
  cidr_blocks              = [aws_vpc.main.cidr_block]
  to_port                  = 22
  type                     = "ingress"
}

#Postgres RDS security group rules

resource "aws_security_group_rule" "db-security-group-rule-allow-1337" {
  description              = "Allow port 1337 nodes to communicate with control plane (all ports)"
  from_port                = 1337
  protocol                 =  "tcp"
  security_group_id        = aws_security_group.allow-tcp.id
  cidr_blocks              = [aws_vpc.main.cidr_block]
  to_port                  = 1337
  type                     = "ingress"
}

resource "aws_security_group_rule" "db-security-group-rule-allow-5432" {
  description              = "Allow port 1337 nodes to communicate with control plane (all ports)"
  from_port                = 5432
  protocol                 =  "tcp"
  security_group_id        = aws_security_group.allow-tcp.id
  cidr_blocks              = [aws_vpc.main.cidr_block]
  to_port                  = 5432
  type                     = "ingress"
}

resource "aws_security_group_rule" "outgoing" {
  description              = "Allow all outgoing"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.allow-tcp.id
  cidr_blocks              = [aws_vpc.main.cidr_block]
  to_port                  = 0
  type                     = "egress"
}