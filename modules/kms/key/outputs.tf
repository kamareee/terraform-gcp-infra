output "crypto_keys" {
    value = {
        for key, config in google_kms_crypto_key.keys : key => {
            name = config.name
            key_ring = config.key_ring
            rotation_period = config.rotation_period
            labels = config.labels
        } 
    }
}
  