output "instance_private_ips" {
  description = "Map of instance name to private IP"
  value = {
    for inst in openstack_compute_instance_v2.instances :
    inst.name => inst.network[0].fixed_ip_v4
  }
}

output "instance_floating_ips" {
  description = "Map of instance name to floating IP (if assigned)"
  value = var.assign_floating_ip ? {
    for idx, inst in openstack_compute_instance_v2.instances :
    inst.name => openstack_networking_floatingip_v2.fips[idx].address
  } : {}
}

output "root_volume_ids" {
  value       = [for v in openstack_blockstorage_volume_v3.root_volumes : v.id]
  description = "IDs of the root volumes for the instances"
}

output "instance_ids" {
  value       = [for i in openstack_compute_instance_v2.instances : i.id]
  description = "IDs of the created instances"
}