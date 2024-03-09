# Blue Environment Module
module "blue_environment" {
  source           = "./environments"
  env_enabled      = var.env_enabled  
  environment_name = var.environment_name
  instance_type    = var.instance_type
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size
  listener_port    = var.listener_port
  alb_priority     = var.alb_priority
  alb_path_pattern = var.alb_path_pattern
}

# Green Environment Module 
module "green_environment" {
  source           = "./environments"
  env_enabled      = var.env_enabled  
  environment_name = var.environment_name
  instance_type    = var.instance_type
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size
  listener_port    = var.listener_port
  alb_priority     = var.alb_priority
  alb_path_pattern = var.alb_path_pattern
}


# DNS record with weighted routing policy 
resource "aws_route53_record" "weighted_routing_record" {
  zone_id = "Z6722HSDJ21M"  
  name    = "casestudy2.com" 
  type    = "A"
 
  weighted_routing_policy {
    weight = var.blue_routing_weight
 
    # Blue environment
    record {
      value = aws_lb.blue_lb.dns_name
    }
  }
 
  weighted_routing_policy {
    weight = var.green_routing_weight
 
    # Green environment
    record {
      value = aws_lb.green_lb.dns_name
    }
  }
}
