variable "security_group_name" {
  type = string
  description = "The name of the security group"
}

variable "description" {
  type = string
  default = "Managed by Terraform"
  description = "The description of the security group"
}

variable "rules" {
  description = <<EOT
  List of rules to apply for this security group.
  Each rule is an object with protocol, port_range_min, port_range_max, remote_ip_prefix.
  EOT
  type = list(object({
    protocol = string
    port_range_min = number
    port_range_max = number
    remote_ip_prefix = string
  }))
  default = []
}
