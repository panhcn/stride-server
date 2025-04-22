variable "region" {}
variable "db_name" {}
variable "db_username" {}
variable "rails_image_url" {}
variable "ecs_execution_role" {}
variable "ecs_task_role" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "ecs_service_sg_id" {}
variable "db_security_group_id" {}
variable "vpc_id" {
  type = string
}
