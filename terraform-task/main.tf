module "network" {
  source = "../modules/network"
  providers = {
    openstack = openstack
  }
  network_name     = "tf-net-341"
  subnet_name      = "tf-subnet-341"
  subnet_cidr      = "192.168.0.0/16"
  router_name      = "tf-router-341"
  external_network = var.external_network
}

module "security" {
  source = "../modules/security"
  providers = {
    openstack = openstack
  }
  security_group_name = "tf-sec-grp-341"

  rules = [
    {
      protocol        = "tcp"
      port_range_min  = 22
      port_range_max  = 22
      remote_ip_prefix = "0.0.0.0/0"
    },
    {
      protocol        = "tcp"
      port_range_min  = 80
      port_range_max  = 80
      remote_ip_prefix = "0.0.0.0/0"
    },
    {
      protocol        = "tcp"
      port_range_min  = 443
      port_range_max  = 443
      remote_ip_prefix = "0.0.0.0/0"
    }
  ]
}

module "compute" {
  source = "../modules/compute"
  providers = {
    openstack = openstack
  }
  instance_count     = 2
  instance_name      = "tf-instance-341"
  flavor_id          = var.flavor_id
  image_id           = var.image_id
  key_pair           = var.key_pair
  assign_floating_ip = var.assign_floating_ip
  network_id         = module.network.network_id
  security_group_ids = [module.security.security_group_id]
  root_volume_size   = 20
  subnet_id = module.network.subnet_id
  external_network_name = var.external_network_name
}

module "loadbalancer" {
  source = "../modules/loadbalancer"
  providers = {
    openstack = openstack
  }
  lb_name        = "tf-lb-341"
  subnet_id      = module.network.subnet_id
  pool_members   = module.compute.instance_private_ips
  health_monitor = var.health_monitor
}