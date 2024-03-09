variable "environment_name" {
}

variable "instance_type" {
 default = "t2.micro"
}

variable "ami_id" {
 default = "ami-0440d3b780d96b29d"
} 

variable "desired_capacity" {
 default = 2
}

variable "max_size" {
 default = 3
}

variable "min_size" {
 default = 1
}

variable "listener_port" {
 default = "443"
}

variable "alb_priority" {
}

variable "alb_path_pattern" {
 default = "/*"
}


variable "env_enabled" {
 default = false
}

variable "blue_routing_weight" {
 default = 1
}

variable "green_routing_weight" {
 default = 1
}