terraform {
  required_providers {
    aws = ">=6.0.0"
    local = ">=2.5.3"
  }
}


provider "aws" {
  region = "us-east-1"
}