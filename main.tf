resource "digitalocean_firewall" "firewall" {
  name = var.name
  tags = var.tags # Droplet tags this firewall applies to

  dynamic "inbound_rule" {
    for_each = var.inbound_tag_rules

    content {
      protocol    = inbound_rule.value.protocol
      port_range  = inbound_rule.value.ports
      source_tags = inbound_rule.value.src
    }

  }

  dynamic "inbound_rule" {
    for_each = var.inbound_addr_rules

    content {
      protocol         = inbound_rule.value.protocol
      port_range       = inbound_rule.value.ports
      source_addresses = inbound_rule.value.src
    }
  }

  dynamic "outbound_rule" {
    for_each = var.outbound_tag_rules

    content {
      protocol         = outbound_rule.value.protocol
      port_range       = outbound_rule.value.ports
      destination_tags = outbound_rule.value.dest
    }
  }

  dynamic "outbound_rule" {
    for_each = var.outbound_addr_rules

    content {
      protocol              = outbound_rule.value.protocol
      port_range            = outbound_rule.value.ports
      destination_addresses = outbound_rule.value.dest
    }
  }
}
