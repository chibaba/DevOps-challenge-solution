# Worker nodes security group to allow port 1337 and 443


resource "aws_security_group_rule" "cluster_inbound_22" {
  description       = "Allow port 22 nodes to communicate with control plane (all ports)"
  from_port         = 1337
  protocol          = "tcp"
  security_group_id = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
  cidr_blocks       = ["0.0.0.0/0"]
  #   source_security_group_id = aws_security_group.eks_nodes.id
  to_port = 1337
  type    = "ingress"
}

resource "aws_security_group_rule" "cluster_inbound_443" {
  description       = "Allow port 443 nodes to communicate with control plane (all ports)"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
  cidr_blocks       = ["0.0.0.0/0"]
  #   source_security_group_id = aws_security_group.eks_nodes.id
  to_port = 443
  type    = "ingress"
}


