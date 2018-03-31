provider "google" {
 version = "1.4.0"
 project = "mydrive-1232"
 region = "europe-west1"
}
resource "google_compute_instance" "app" {
  name = "reddit-app-terra"
  machine_type = "g1-small"
  zone = "europe-west1-b"
  boot_disk {
    initialize_params {
      image = "reddit-full"
    }
  }
  network_interface {
  network = "default"
  access_config {}
  }
}
