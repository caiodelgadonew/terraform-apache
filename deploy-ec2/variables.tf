variable "region" {
  description = "Define what region the instance will be deployed"
  default = "us-east-1"
}

variable "name" {
  description = "Name of the Application"
  default = "apache-websrv"
}

variable "env" {
  description = "Environment of the Application"
  default = "prod"
}

variable "squad" {
  description = "Owner Squad of the Application"
  default = "devops-squad"
}

variable "instance_type" {
  description = "AWS Instance type defines the hardware configuration of the machine"
  default = "t2.micro"
}

variable "tcp_ports" {
  description = "Required Ingress TCP ports"
  default     = ["80", "443"]
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks that are allowed to access the instance"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
