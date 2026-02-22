path "transit/*" {
  capabilities = ["create", "read", "update", "delete"]
}

path "transit/*/rotate" {
  capabilities = ["update"]
}

path "transit/*" {
  capabilities = ["update"]
}

path "transit/*" {
  capabilities = ["update"]
}