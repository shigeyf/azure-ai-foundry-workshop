// envs/dev/variables.tf

variable "project" {
  type        = string
  description = "The project or workload name for the resources"
}

variable "environment" {
  type        = string
  description = "The environment name for the resources"
}

variable "location" {
  type        = string
  description = "The location/region where the resources will be created"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}
