output "lb_vip_address" {
  value = openstack_lb_loadbalancer_v2.this.vip_address
  description = "The IP address of the loadbalancer created"
}

output "lb_id" {
  value = openstack_lb_loadbalancer_v2.this.id
  description = "The ID of the loadbalancer created"
}