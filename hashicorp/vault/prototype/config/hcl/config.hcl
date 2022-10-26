disable_mlock = true
ui            = true

listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_cert_file = "/etc/vault/ssl/self.crt"
  tls_key_file  = "/etc/vault/ssl/self.key"
  // tls_disable = "true"
}

storage "file" {
  path = "/vault/data"
}