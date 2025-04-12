resource "google_storage_bucket" "storage_bucket" {
  for_each = { for config in var.var.bucket_configurations : config.bucket_name => config }
  name = "${var.common_configurations.project_id}-${each.key}"
  project = var.common_configurations.project_id
  location = var.common_configurations.region
  force_destroy = "${each.value.force_destroy}"
  uniform_bucket_level_access = "${each.value.uniform_bucket_level_access}"
  storage_class = "${each.value.storage_class}"
  labels = "${each.value.labels}"

  encryption {
    default_kms_key_name = "${each.value.storage_key}"
  }

  versioning {
    enabled = "${each.value.versioning.enabled}"
  }
  
}