variable "cluster_name" { type = string }
variable "environment"  { type = string }
variable "vpc_cidr"     { default = "10.0.0.0/16" }
variable "availability_zones" {
  default = ["ap-southeast-2a", "ap-southeast-2b"]
}
