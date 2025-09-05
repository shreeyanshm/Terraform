terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

resource "openstack_networking_secgroup_v2" "this" {
  name = var.security_group_name
  description = var.description
}

resource "openstack_networking_secgroup_rule_v2" "this" {
  for_each = {for idx, rule in var.rules : idx => rule}

  direction = "ingress"
  ethertype = "IPv4"
  protocol = each.value.protocol
  port_range_min = each.value.port_range_min
  port_range_max = each.value.port_range_max
  remote_ip_prefix = each.value.remote_ip_prefix
  security_group_id = openstack_networking_secgroup_v2.this.id
}
