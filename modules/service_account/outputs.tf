output "service_account_info" {
    value = [
      for sa in google_service_account.service_account : {
        name = sa.name
        email = sa.email
      }
    ]
}