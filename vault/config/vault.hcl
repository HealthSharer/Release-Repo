ui = true

storage "raft" {
  path    = "/vault/data"
  node_id = "node1"
}

listener "tcp" {
  address         = "0.0.0.0:8200"
  tls_disable     = true
}

audit {
  file_path = "/vault/logs/audit.log"
  log_raw   = false
}

api_addr     = "https://vault.healthsharer.live"
cluster_addr = "http://kms_vault:8201"

disable_mlock = true