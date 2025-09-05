terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

resource "openstack_blockstorage_volume_v3" "root_volumes" {
    count = var.instance_count
    name = "${var.instance_name}-root-${count.index + 1}"
    size = var.root_volume_size
    image_id = var.image_id
}

resource "openstack_networking_port_v2" "ports" {
    count=var.instance_count
    name = "${var.instance_name}-port-${count.index + 1}"
    network_id = var.network_id
    security_group_ids = var.security_group_ids

    fixed_ip {
      subnet_id = var.subnet_id
    }
}

resource "openstack_compute_instance_v2" "instances" {
  count = var.instance_count
  name = "${var.instance_name}-${count.index + 1}"
  flavor_id = var.flavor_id
  key_pair = var.key_pair

  block_device {
    uuid = openstack_blockstorage_volume_v3.root_volumes[count.index].id
    source_type = "volume"
    destination_type = "volume"
    delete_on_termination = true
    boot_index = 0
  }
  network {
    port = openstack_networking_port_v2.ports[count.index].id
  }
}

resource "openstack_networking_floatingip_v2" "fips" {
  count = var.assign_floating_ip ? var.instance_count : 0
  pool = var.external_network_name
}

resource "openstack_networking_floatingip_associate_v2" "fip_assoc" {
    count = var.assign_floating_ip ? var.instance_count : 0
    floating_ip = openstack_networking_floatingip_v2.fips[count.index].address
    port_id = openstack_networking_port_v2.ports[count.index].id
}