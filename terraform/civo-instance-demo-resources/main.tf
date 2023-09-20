terraform {
  required_providers {
    civo = {
      source = "civo/civo"
    }
  }
}

variable api_key {
  type        = string
  default     = ""
  description = "CIVO Cloud API key"
}

provider "civo" {
  token = var.api_key
  region = "LON1"
}

resource "civo_instance" "foo" {
    hostname = "tfcontroller.demo"
    tags = ["hello", "kcd", "austria"]
    notes = "This server was created via tf-controller"
    size = "g3.small"
    disk_image = "debian-10"
}

output "public_ip" {
  value = data.civo_instance.myhostaname.public_ip
}
