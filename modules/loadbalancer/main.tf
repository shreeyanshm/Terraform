terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

resource "openstack_lb_loadbalancer_v2" "this" {
 name=var.lb_name
 vip_subnet_id = var.subnet_id
#  loadbalancer_provider = "octavia"
}

resource "openstack_lb_listener_v2" "this" {
  name = "${var.lb_name}-listener"
  protocol = var.protocol
  protocol_port = var.listener_port
  loadbalancer_id = openstack_lb_loadbalancer_v2.this.id
}

resource "openstack_lb_pool_v2" "this" {
  name = "${var.lb_name}-pool"
  protocol = var.protocol
  lb_method = "ROUND_ROBIN"
  listener_id = openstack_lb_listener_v2.this.id
}

resource "openstack_lb_member_v2" "members" {
  for_each = var.pool_members
  address = each.value
  protocol_port = var.listener_port
  pool_id = openstack_lb_pool_v2.this.id
  subnet_id = var.subnet_id
}

resource "openstack_lb_monitor_v2" "this" {
  name = "${var.lb_name}-monitor"
  pool_id = openstack_lb_pool_v2.this.id
  type = var.health_monitor.type
  delay = var.health_monitor.delay
  timeout = var.health_monitor.timeout
  max_retries = var.health_monitor.max_retries
}