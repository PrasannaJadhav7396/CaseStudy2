environment_name = "green"
instance_type    = "t2.micro"
desired_capacity = 2
max_size         = 3
min_size         = 1
listener_port    = 443
alb_priority     = 200
alb_path_pattern = "/*"

env_enabled      = false

green_routing_weight = 1