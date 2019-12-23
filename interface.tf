#############################
### Begin input variables ###
#############################
variable "name" {
  description = "Name of DigitalOcean firewall."
  type        = string
}

variable "tags" {
  description = "List of Droplet tags firewall is applied to."
  type        = list(string)
}

variable "inbound_tag_rules" {
  description = "Inbound firewall rules to be configured using Droplet tags."
  type = list(object({
    protocol = string
    ports    = string
    src      = list(string)
  }))
  default = []
}

variable "inbound_addr_rules" {
  description = "Inbound firewall rules to be configured using IP addresses."
  type = list(object({
    protocol = string
    ports    = string
    src      = list(string)
  }))
  default = [
    {
      protocol = "tcp"
      ports    = "22"
      src      = ["0.0.0.0/0"]
    }
  ]
}

variable "outbound_tag_rules" {
  description = "Outbound firewall rules to be configured using Droplet tags."
  type = list(object({
    protocol = string
    ports    = string
    dest     = list(string)
  }))
  default = []
}

variable "outbound_addr_rules" {
  description = "Outbound firewall rules to be configured using IP addresses."
  type = list(object({
    protocol = string
    ports    = string
    dest     = list(string)
  }))
  default = [
    {
      protocol = "tcp"
      ports    = "1-65535"
      dest     = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol = "udp"
      ports    = "1-65535"
      dest     = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol = "icmp"
      ports    = "1-65535"
      dest     = ["0.0.0.0/0", "::/0"]
    }
  ]
}

##############################
### Begin output variables ###
##############################

output "fw_rules" {
  value = digitalocean_firewall.firewall
}
