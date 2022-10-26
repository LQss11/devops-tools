disable_mlock = true
ui            = true
api_addr = "https://0.0.0.0:443"

listener "tcp" {
  address       = "0.0.0.0:443"
  tls_disable = 0
  tls_cert_file = "/etc/vault/ssl/self.crt"
  tls_key_file  = "/etc/vault/ssl/self.key"
}

storage "file" {
  path = "/vault/data"
}