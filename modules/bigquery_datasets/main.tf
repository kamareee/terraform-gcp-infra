# Define resources for BigQuery datasets

# Geeneral datasets
resource "google_bigquery_dataset" "datasets" {
    for_each = { for idx, dataset in var.bigquery_dataset_configurations : "${dataset.name}" => dataset if !dataset.binding_only }

    dataset_id = each.value.name
    location = var.common_configurations.region
    project = var.common_configurations.project_id

    labels = each.value.labels

    # Conigure default encryption for each dataset
    default_encryption_configuration {
      kms_key_name = each.value.bq_dataset_key
    }
}

resource "google_bigquery_table" "tables" {
    for_each = { for idx, table in var.bigquery_table_configurations : "${table.table_id}" => table }

    table_id = each.value.table_id
    dataset_id = each.value.dataset_id

    schema = each.value.schema

    labels = each.value.labels

    dynamic "time_partitioning" {
        for_each = each.value.time_partitioning != null ? [1] : []
        content {
            type = each.value.time_partitioning.type
            field = each.value.time_partitioning.field
            expiration_ms = each.value.time_partitioning.expiration_ms
        }
    }

    # Add encryption to the table
    encryption_configuration {
      kms_key_name = each.value.bq_table_key
    }
    # ensure the table is created after the dataset
    depends_on = [
        google_bigquery_dataset.datasets
    ]
    
    lifecycle {
      ignore_changes = [ 
        terraform_labels,
        labels,
        effective_labels,
        require_partition_filter,
        clustering,
       ]
    }
}
