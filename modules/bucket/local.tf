locals {
  google_storage_bucket_iam_bindings = flatten([
    for bucket in var.bucket_configurations :
    [
        for binding in bucket.iam_bindings :
         [
        for roles in binding.role:
        {
            name = "${var.common_configurations.project_id}-${bucket.bucket_name}"
            role = roles
            member = binding.member
        }
    ]
    ]
    if length(bucket.iam_bindings) > 0
  ])
}