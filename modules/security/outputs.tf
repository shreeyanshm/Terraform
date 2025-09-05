output "security_group_id" {
  value = openstack_networking_secgroup_v2.this.id
  description = "The ID of the security group created"
}