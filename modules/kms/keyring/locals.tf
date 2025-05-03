locals {
    unique_key_rings = distinct([for config in var.keyring_configurations : config.key_ring_name])
}