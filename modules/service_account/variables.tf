variable "common_configurations" {
    type = object({
      project_id = string
      projectname = string
      region = string
      env = string
    })
}


variable "service_accounts_configurations" {
  description = "list of service accounts"
  type = list(object({
    name = string
    display_name = string
    iam_bindings = list(object({
        role = list(string)
        member = list(string)
    }))
    labels = optioal(map(string), {
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