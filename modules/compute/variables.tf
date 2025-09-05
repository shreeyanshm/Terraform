variable "instance_count" {
  type = number
  default = 1
  description = "Number of instance to create"
}

variable "instance_name" {
  type = string
  description = "Base name of the instances"
}

variable "image_id" {
  type = string
  description = "The ID of the image as source for boot volume"
}

variable "root_volume_size" {
  type = number
  description = "Size of the root volume in GB"
}

variable "flavor_id" {
    type =  string
    description = "The flavor id for the instance"
}

variable "key_pair" {
  type = string
  description = "The key-value pair name"
}

variable "network_id" {
  type = string
  description = "The network ID to associate with instance"
}

variable "security_group_ids" {
  type = list(string)
  description = "The list of ID of the security groups"
}

variable "assign_floating_ip" {
  type = bool
  default = false
  description = "Whether to assign floating ip to instance"
}

variable "external_network_name" {
    type = string
    description = "Name of the external network for floating ip"
    default = null
}

variable "subnet_id" {
  type = string
  description = "Subnet ID for ports of the instances"
}