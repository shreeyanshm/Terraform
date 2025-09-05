output "private_ips" {
  description = "Instance name to private IP mapping"
  value       = module.compute.instance_private_ips
}

output "floating_ips" {
  description = "Instance name to floating IP mapping"
  value       = module.compute.instance_floating_ips
}

output "loadbalancer_vip" {
  description = "Load balancer virtual IP"
  value       = module.loadbalancer.lb_vip_address
}
