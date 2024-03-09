environment_name = "blue"
instance_type    = "t3.small"
desired_capacity = 2
max_size         = 3
min_size         = 1
listener_port    = 443
alb_priority     = 100
alb_path_pattern = "/*"

env_enabled      = true

blue_routing_weight = 1