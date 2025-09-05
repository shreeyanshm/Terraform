variable "lb_name" {
  type = string
  description = "The name of the loadbalancer"
}

variable "subnet_id" {
  type = string
  description = "The ID of the subnet where the loadbalancer will be created"
}

variable "listener_port" {
  type = number
  default = 80
  description = "Port for listener (80 for HTTP, 443 for HTTPS)"
}

variable "protocol" {
  type = string
  default = "HTTP"
  description = "Protocol for listener(HTTPS, HTTP)"
}

variable "pool_members" {
  type = map(string)
  description = "List of member IP addresses of the pool"
}

variable "health_monitor" {
  description = "Health monitor configuration"
  type = object({
    type = string
    delay = number
    timeout = number
    max_retries = number
  })

  default = {
    type = "HTTP"
    delay = 5
    timeout = 3
    max_retries = 3
  }
}