resource "google_storage_bucket_iam_binding" "bucket_iam_binding" {
  for_each = { for index, binding in local.google_storage_bucket_iam_bindings : "${binding.name}-${binding.role}" => binding }

  bucket = each.value.name
  role = each.value.role
  members = each.value.member
  depends_on = [ 
    google_storage_bucket.storage-bucket
   ]
}