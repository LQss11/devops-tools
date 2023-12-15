variable "subnets" {
  default = {
    "subnet" = {
      inbound_ports = ["22", "3389", "1433"]
    },
    "subnet2" = {
      inbound_ports = ["1433"]
    }
  }
}

resource "local_file" "myfiles" {
  for_each = toset(
    flatten(
      [
        for s, details in var.subnets : [
          for p in details.inbound_ports : "${s}-${p}"
        ]
      ]
    )
  )
  filename = join("", [each.key, ".json"])
  content  = element(split("-", each.key), 1)
}
