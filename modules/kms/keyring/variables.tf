variable "common_configuration" {
  type = object({
    project_id  = string
    projectname = string
    region      = string
    env         = string
  })
}

variable "keyring_configurations" {
    type = list(object({
      key_ring_name = string
      key_name = string
      prevent_destroy = optional(bool, true)
      rotation_period = optional(string, "31560000s") # 1 year
      labels = optional(map(string), {
        "integrity" = "accurate"
        "confidentiality" = "confidential"
        "trustlevel" = "high"
        "domain" = ""
        "owneremail" = ""
        "app_name" = ""
      })
      iam_binding = optional(object({
        role = string
        members = list(string)
      }), null)
    }))
}

variable "keyring_members" {
  type = list(string)
  description = "Identities to be granted viewer access to the key ring."
  default = []
}