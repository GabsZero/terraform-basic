variable "prefix" {}
variable "cluster_name" {
  default = "terraform-basic-cluster"
}
variable "desired_size" {
  default = 2
}

variable "max_size" {
  default = 3
}

variable "min_size" {
  default = 1
}

variable "subnet_ids" {
  description = "Lista de ids de sub-redes onde o cluster será criado."
  type        = list(string)

}

variable "vpc_id" {
  description = "O id da vpc onde o cluester será criado."
  type        = string

}
