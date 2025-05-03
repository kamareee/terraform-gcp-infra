resource "google_bigquery_dataset_iam_binding" "dataset_iam_binding" {
  # Generate one IAM binding resource for each unique combination of name, role, and type in lcoal.all_iam_bindings
  for_each = {
    for idx, binding in local.all_iam_bindings :
    "${binding.name}" => binding if binding.table_name == ""
  }

  dataset_id = each.value.name
  project = var.common_configurations.project_id
  role = each.value.role
  members = each.value.member
  depends_on = [
    google_bigquery_dataset.datasets
  ] 
}

resource "google_bigquery_table_iam_binding" "table_iam_binding" {
  # Generate one IAM binding resource for each unique combination of name, role, and type in local.all_iam_bindings
  for_each = {
    for idx, binding in local.all_iam_bindings :
    "${binding.name}-${binding.table_name}" => binding if binding.table_name != ""
  }

  dataset_id = each.value.name
  table_id = each.value.table_name
  project = var.common_configurations.project_id
  role = each.value.role
  members = each.value.member
  depends_on = [
    google_bigquery_dataset.datasets,
    google_bigquery_table.tables
  ] 
}