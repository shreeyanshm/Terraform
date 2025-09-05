terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

resource "openstack_networking_network_v2" "this" {
  name= var.network_name
}

resource "openstack_networking_subnet_v2" "this" {
  name= var.subnet_name
  cidr = var.subnet_cidr
  network_id = openstack_networking_network_v2.this.id
  ip_version = 4
}

resource "openstack_networking_router_v2" "this" {
  name=var.router_name
  external_network_id = var.external_network
}

resource "openstack_networking_router_interface_v2" "this" {
  router_id = openstack_networking_router_v2.this.id
  subnet_id = openstack_networking_subnet_v2.this.id
}