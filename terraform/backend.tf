terraform {
  backend "gcs" {
    bucket = "storage-bucket-bulnv"
    path   = "terraform.tfstate"
    prefix = "prod"
  }
}
