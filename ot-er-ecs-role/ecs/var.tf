variable "auto_scaling_group_arn" {
  type = string
}
variable "cluster_name" {
  type = string
}
variable "tags" {
  type = map(any)
}
variable "target_group_arn" {
  type = string
}