resource "google_kms_crypto_key_iam_binding" "crypto_key_bindings" {
    for_each = {
       for index, binding in local.key_iam_bindings : "${binding.name}-${binding.role}-${index}" => binding
    }

    crypto_key_id = "${var.common_configurations.project_id}/${var.common_configurations.regrion}/${each.value.key_ring_name}/${each.value.name}"
    role          = each.value.role
    members = concat(var.key_name_to_members, each.value.member)
    depends_on = [ 
        google_kms_crypto_key.keys
     ]
}