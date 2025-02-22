resource "google_service_account" "service_account" {
  count = length(var.service_accounts_configurations)
  account_id = var.service_accounts_configurations[count.index].name
  display_name = var.service_accounts_configurations[count.index].display_name
  project = var.common_configurations.project_id
  
}