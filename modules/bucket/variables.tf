variable "common_configuration" {
  type = object({
    project_id  = string
    projectname = string
    region      = string
    env         = string
  })
}

// Bucket variables

variable "bucket_configurations" {
    type = list(object({
      bucket_name = string
      iam_bindings = list(object({
        role    = list(string)
        members = list(string)
      }))
      storage_class = optional(string, "STANDARD")
      storage_key = optional(string)
      versioning = optional(object({
        enabled = bool
      }), {
        enabled = false
      })
      force_destroy = optional(bool, false)
      uniform_bucket_level_access = optional(bool, false)
      labels = optional(map(string), {
        integrity = "accurate"
        confidentiality = "confedential"
        trustlevel = "high"
        owner_email = ""
        app_name = ""
        domain = ""
        owneremail = ""
      })
    }))
}