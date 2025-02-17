resource "google_project_iam_member" "group_iam_members" {
   for_each = {for binding in local.formatted_iam_members : "${binding.group}-${binding.role}" => binding}

    project = var.common_configuration.project_id
    role    = each.value.role
    member  = each.value.member
}