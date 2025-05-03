output "self_link" {
    description = "The self link of the keyring."
    value       = {
        for key, resource in googoogle_kms_key_ring.key-ring :
        key => resource.id
    }
}

output "key_ring_id" {
    description = "The ID of the created keyring."
    value       = {
        for key, resource in google_kms_key_ring.key-ring :
        key => resource.id
    }
}

output "key_ring_name" {
    description = "The name of the created keyring."
    value       = {
        for key, resource in google_kms_key_ring.key-ring :
        key => resource.name
    }
}