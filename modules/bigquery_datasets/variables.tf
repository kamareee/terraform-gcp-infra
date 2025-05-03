variable "common_configuration" {
  type = object({
    project_id  = string
    projectname = string
    region      = string
    env         = string
  })
}

variable "bigquery_dataset_configurations" {
  type = list(object({
    name = string
    binding_only = optional(bool, false)
    bq_dataset_key = optional(string)
    iam_binding = list(object({
        table_name = optional(list(string), [])
        role = list(string)
        member = list(string)
    }))
    labels = optional(map(string), {
        integrity = "accurate"
        confiedntality = "confidential"
        trustlevel = "high"
        owneremail = ""
        app_name = ""
    })
  })) 
}

variable "bigquery_table_configurations" {
   description = "Bigquery table configurations"
   type = list(object({
     dataset_id = string
     table_id = string
     bq_table_key = optional(string)
     time_partitioning = optional(object({
       type = string
       field = optional(string, "")
       expiration_ms = optional(number)
     }))
     schema = string
     labels = optional(map(string), {
       integrity = "accurate"
       confidentiality = "confidential"
       trustlevel = "high"
       owneremail = ""
       app_name = ""
     })
   }))
}