resource "google_service_account_iam_binding" "service_account_iam_binding" {
  for_each = { for index, binding in local.service_accounts_iam_bindings : "${binding.name}-${binding.role}" => binding }

  service_account_id = each.value.name
  role = each.value.role
  members = each.value.member
  depends_on = [ 
    google_service_account.service_account
   ]
}