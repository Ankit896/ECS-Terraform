variable "vpc_id" {
  type = string
}
variable "public_subnet_id" {
  type = list(any)
}
variable "iam_instance_profile" {
  type = string
}
variable "key_name" {
  type = string
}
variable "tags" {
  type = map(any)
}