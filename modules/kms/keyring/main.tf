resource "google_kms_key_ring" "key-ring" {
   count = length(local.unique_key_rings) 
   name = "${var.common_configurations.project_name}-${local.unique_key_rings[count.index]}"
   project = var.common_configurations.project_id
   location = var.common_configurations.region
}