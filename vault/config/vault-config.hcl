# Listener configuration
listener "tcp" {
  address     = "0.0.0.0:8200" # Listen on all network interfaces
  tls_disable = 1              # Disable TLS for development (use TLS in production)
}

# Storage backend configuration
storage "file" {
  path = "/vault/data"          # Path to store Vault data
}

# API address
api_addr = "http://localhost:8200" # Replace with the correct address for your environment

# Enable the Vault UI
ui = true

# Disable memory lock (required for Docker)
disable_mlock = true