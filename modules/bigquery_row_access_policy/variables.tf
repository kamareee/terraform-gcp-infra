variable "common_configuration" {
  type = object({
    project_id  = string
    projectname = string
    region      = string
    env         = string
  })
}

variable "row_access_policies"  {
    description = "A list of row access policies to be created"
    type = list(object({
        row_policy_name = string  # Row access policy name
        dataset_id = string # Dataset ID
        table_id = string # Table ID
        grant_access_to = list(string)
        row_filter = string 
        skip_filter_to = optional(list(string), [])
    }))

    default = []

    validation {
      condition = alltrue([
        #  Validate that all grant_access_to values are in correct format
        alltrue([for policy in var.row_access_policy : alltrue([for principal in policy.grant_access_to : can(regex("^(group|user|serviceAccount):[^@]+@[^@]+\\.[^@]+$", principal))])]),
        # Validate that all skip_filter_to values are in correct format
        alltrue([for policy in var.row_access_policy : alltrue([for principal in policy.skip_filter_to : can(regex("^(group|user|serviceAccount):[^@]+@[^@]+\\.[^@]+$", principal))])]),
      ])

      error_message = "Each principal in grant_access_to and skip_filter_to must be in the format 'group:<email>' 'user:<email>' or 'serviceAccount:<email>'."
    }
}