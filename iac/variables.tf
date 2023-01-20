variable "private_subnet_b_cidr_block" {
  type    = string
  default = "10.0.5.0/24"
}

variable "private_subnet_c_cidr_block" {
  type    = string
  default = "10.0.6.0/24"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_subnet_a_cidr_block" {
  type    = string
  default = "10.0.4.0/24"
}


variable "public_subnet_c_cidr_block" {
  type    = string
  default = "10.0.3.0/24"
}

variable "public_subnet_b_cidr_block" {
  type    = string
  default = "10.0.2.0/24"
}

variable "public_subnet_a_cidr_block" {
  type    = string
  default = "10.0.1.0/24"
}

variable "db_username" {
  description = "Database administrator username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  type    = string
  default = "postgres"
}

variable "db_engine" {
  type    = string
  default = "postgres"
}
variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_parameter_group" {
  type    = string
  default = "default.postgres13"
}

variable "eks_instance_type" {
  type    = string
  default = "t3.small"
}