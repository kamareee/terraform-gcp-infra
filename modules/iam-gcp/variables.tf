variable "common_configuration" {
  type = object({
    project_id  = string
    projectname = string
    region      = string
    env         = string
  })
}

variable "persona_group_format_string" {
  description = "Format the group name for Terraform readability"
  type = string
  default = "group:GCP_DP_%s@<something.com>"
}

variable "groups" {
  description = "List of groups and roles to assign to them"
  type = map(list(string))
  default = {}
}