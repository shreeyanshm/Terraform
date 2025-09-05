variable "network_name"{
    type = string
    description = "Name of the private network"
}

variable "subnet_name"{
    type = string
    description = "Name of the private subnet"
}

variable "subnet_cidr"{
    type = string
    description = "CIDR of the private subnet"
}

variable "router_name"{
    type = string
    description = "Name of the Router"
}

variable "external_network"{
    type = string
    description = "Name of the External Network"
}

variable "is_external"{
    type = bool
    description = "is the network external or private"
    default = false
}