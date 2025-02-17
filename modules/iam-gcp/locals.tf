locals {
  formatted_iam_members = flatten([
    for group_name, roles in var.groups : [
        for role in roles: {
            group = var.common_configuration.env != "prod" ? replace(format(var.persona_group_format_string, group_name), "GCP_", "GCP_${upper(var.common_configurations.env)}_") : format(var.persona_group_format_string, group_name)
        }
    ]
  ])
}