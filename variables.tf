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
