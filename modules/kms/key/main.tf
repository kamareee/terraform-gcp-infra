resource "google_kms_crypto_key" "keys" {
    for_each = {for idx, config in var.keyring_configurations : "${config.key_name}-${idx}" => config}

    name = "${var.common_configurations.project_id}-${each.value.key_name}"
    key_ring = "projects/${var.common_configurations.project_id}/locations/${var.common_configurations.region}/keyRings/${var.common_configurations.projectname}-${each.value.key_ring_name}"
    rotation_period = each.value.rotation_period
    labels = each.value.labels
    lifecycle {
        prevent_destroy = true
    }
}