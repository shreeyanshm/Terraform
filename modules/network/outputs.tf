output "router_id"{
    value=openstack_networking_router_v2.this.id
    description = "The ID of the router created"
}

output "network_id" {
  value = openstack_networking_network_v2.this.id
  description = "The ID of the network created"
}

output "subnet_id" {
  value=openstack_networking_subnet_v2.this.id
  description = "The ID of the subnet created"
}