locals {
  service_accounts_iam_bindings = flatten([
    for account in var.service_accounts_configurations :
    [
        for binding in account.iam_bindings :
         [
        for roles in binding.role:
        {
            name = "projects/${var.common_configurations.project_id}/serviceAccounts/${account.name}@${var.common_configurations.project_id}.iam.gserviceaccount.com"
            role = roles
            member = binding.member
        }
    ]
    ]
    if length(account.iam_bindings) > 0
  ])
}