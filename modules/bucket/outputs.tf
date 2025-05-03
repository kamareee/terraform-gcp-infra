output "bucket_id" {
    description = "The ID of the bucket"
    value = {
        for key, resource in googoogle_storage_bucket.storage_bucket :
        key => resource.id
    }
}

output "bucket_name" {
    description = "The name of the bucket"
    value = {
        for key, resource in google_storage_bucket.storage_bucket :
        key => resource.name
    }
}