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

variable "key_name" {
  type    = string
  default = "bashir"
}

variable "eks_cluster" {
  type    = string
  default = "eks"
}

variable "eks_version" {
  type    = string
  default = "1.19"
}

variable "eks_ami_type" {
  type    = string
  default = "AL2_x86_64"
}

variable "eks_capacity_type" {
  type    = string
  default = "ON_DEMAND"
}

variable "eks_node_group" {
  type    = string
  default = "eks-node-group-general"
}

variable "eks_iam_policy_attachment" {
  type    = string
  default = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

variable "eks_iam_cni_policy" {
  type    = string
  default = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

variable "amazon_ec2_container_registry_read_only" {
  type    = string
  default = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

variable "eks_node_group_name" {
  type    = string
  default = "node-general"
}

variable "account_id" {
  type    = string
  sensitive   = true
}