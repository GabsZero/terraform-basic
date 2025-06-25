resource "aws_security_group" "security_group" {
  name        = "${var.prefix}-security-group"
  description = "Security group for the cluster"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_iam_role" "cluster_role" {
  name = "${var.cluster_name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSVPCResourceController" {
  role       = aws_iam_role.cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSClusterPolicy" {
  role       = aws_iam_role.cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_cloudwatch_log_group" "cloud_watch_log_group" {
  name              = "${var.prefix}-cloudwatch-log-group"
  retention_in_days = 7

}

resource "aws_eks_cluster" "cluster" {
  name     = "${var.prefix}-${var.cluster_name}"
  role_arn = aws_iam_role.cluster_role.arn
  enabled_cluster_log_types = [
    "api",
    "audit"
  ]
  vpc_config {
    subnet_ids         = aws_subnet.subnets.*.id
    security_group_ids = [aws_security_group.security_group.id]
  }
  depends_on = [
    aws_cloudwatch_log_group.cloud_watch_log_group,
    aws_iam_role_policy_attachment.cluster-AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy
  ]
}
