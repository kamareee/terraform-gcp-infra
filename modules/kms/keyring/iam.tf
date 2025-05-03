resource "google_kms_key_ring_iam_binding" "key_ring_iam_binding" {
    for_each = {for idx, key_ring_name in local.unique_key_rings : key_ring_name => idx}
    key_ring_id = "${var.common_configurations.project_id}/${var.common_configurations.region}/${var.common_configurations.projectname}-${each.key}"
    role = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
    members = var.keyring_members
    depends_on = [ 
        google_kms_key_ring.key-ring
     ]
}