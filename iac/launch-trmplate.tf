# Launch template for the worker nodes
resource "aws_launch_template" "eks-nodes-launch" {
  name = "boo"

  instance_type = var.eks_instance_type
  key_name      = var.key_name


  vpc_security_group_ids = [aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id]


  user_data = filebase64("script.sh")
}