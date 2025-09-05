variable "key_pair" {
  type        = string
  description = "SSH key pair name"
}

variable "flavor_id" {
  type        = string
  description = "Flavor id for instances"
}

variable "image_id" {
  type        = string
  description = "Image ID for instance"
}

variable "assign_floating_ip" {
  type        = bool
  default     = false
  description = "Whether to assign floating ip"
}

variable "external_network" {
  type = string
  description = "ID of the external network"
}
variable "external_network_name" {
  type = string
  description = "Name of the external network"
}
variable "health_monitor" {
  description = "Health Monitor config for lb"

  type = object({
    type        = string
    delay       = number
    timeout     = number
    max_retries = number
  })
  default = {
    type        = "HTTP"
    delay       = 5
    timeout     = 3
    max_retries = 3
  }
}