# Create row access policies with the specified filter
resource "google_bigquery_job" "create_row_access_policy" {
    for_each = { for policy in var.row_access_policies : "${policy.row_policy_name}-filter" => policy }

    job_id = "create-row-access-policy-${each.key}-${substr(uuid(), 0, 5)}"
    location = var.common_configurations.region

    query {
        query = <<-EOT
          CREATE OR REPLACE ROW ACCESS POLICY ${each.value.row_policy_name}
          ON ${each.value.dataset_id}.${each.value.table_id}
          GRANT TO (${join(",", [for p in each.value.grant_access_to : "\"${p}\""])})
          FILTER USING (${each.value.row_filter}); 
        EOT

        create_disposition = ""
        write_disposition = ""
    }

    lifecycle {
      ignore_changes = [ 
       ]
    }
}

# Conditionally create filter policy if skip_filter_to is present
resource "google_bigquery_job" "create_true_filter_policy" {
    for_each = {
      for policy in var.var.row_access_policies : "${policy.row_policy_name}-true-filter" => policy 
      if length(policy.skip_filter_to) > 0
    }

    job_id = "create-row-access-policy-true-${each.key}-${uuid()}"
    location = var.common_configurations.region

    query {
        query = <<-EOT
          CREATE OR REPLACE ROW ACCESS POLICY ${each.value.row_policy_name}_true
          ON ${each.value.dataset_id}.${each.value.table_id}
          GRANT TO (${join(",", [for p in each.value.grant_access_to : "\"${p}\""])})
          FILTER USING (TRUE)
        EOT

        create_disposition = ""
        write_disposition = ""
    }

    lifecycle {
      ignore_changes = [ ]
    }
}