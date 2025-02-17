// global/variables.tf

// Azure resource naming convensions
//  resource_prefix + project + environment + location + resource_instance_unique_id
//

variable "project" {
  description = "The project name for the resources"
  type        = string
}

variable "environment" {
  description = "The environment name for the resources"
  type        = string
}

variable "location" {
  description = "The location for the resources"
  type        = string
}
