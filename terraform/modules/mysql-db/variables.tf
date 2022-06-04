variable "region" {
  description = "The region to launch the instances"
  default     = "eu-west-1"
}

variable "vpc_private_subnet_ids" {
  description = "Variable for private subnet identifier"
  type = list(any)

}
variable "vpc_id" {
  description = "Variable for vpc ID identifier"
  type = string
}
