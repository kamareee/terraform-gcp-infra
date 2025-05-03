locals {
  key_iam_bindings = flatten([
    for key in var.keyringvar.keyring_configurations : 
    [
      for binding in key.iam_bindings :
      [
        for roles in binding.role :
        {
            name = "${var.common_configurations.project_id}-${key.key_name}"
            key_ring_name = "${var.common_configurations.projectname}-${key.key_ring_name}"
            role = roles
            members = binding.member
        }
      ]
    ]
    if length(key.iam_bindings) > 0
  ])
}