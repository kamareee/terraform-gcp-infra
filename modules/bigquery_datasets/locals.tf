locals {
  all_iam_bindings = flatten([
    for config in var.bigquery_dataset_configurations : 
    [
      for dataset_binding in config.iam_bindings : 
      [
        for table_name in(length(dataset_binding.table_name) == 0 ? [""] : dataset_binding.table_name) :
        [
          for role in dataset_binding.role :
          {
            name = "${config.name}"
            table_name = table_name
            role = role
            member = dataset_binding.member
          }
        ] 
      ]
      
    ]
    if(length(config.iam_bindings) > 0)
  ])
}