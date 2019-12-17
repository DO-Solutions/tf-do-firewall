resource "digitalocean_firewall" "firewall" {
  name = var.name
  tags = var.tags # Droplet tags this firewall applies to

  dynamic "inbound_rule" {
    for_each = var.inbound_tag_rules

    content {
      protocol = inbound_rule.value.protocol
      port_range = inbound_rule.value.ports
      source_tags = inbound_rule.value.src
    }

  }

  # rule sets
  # protocol - port (range) - source ip (range)
}
