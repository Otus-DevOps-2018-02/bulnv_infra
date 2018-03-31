variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1-c"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable public_another_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable private_key_path {
  description = "private key location"
}
variable private_another_key_path {
  description = "another key"
}
