locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${aws_eks_cluster.cluster.certificate_authority[0].data}
    server: ${aws_eks_cluster.cluster.endpoint}
  name: kubernets
contexts:
- context:
    cluster: kubernets
    user: ${aws_eks_cluster.cluster.name}
  name: ${aws_eks_cluster.cluster.name}
current-context: ${aws_eks_cluster.cluster.name}
kind: Config
preferences: {}
users:
- name: ${aws_eks_cluster.cluster.name}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${aws_eks_cluster.cluster.name}"
KUBECONFIG
}

resource "local_file" "kubeconfig" {
  content  = local.kubeconfig
  filename = "${path.module}/kubeconfig"

}
