resource "google_compute_instance_template" "reddit-app-template" {
  name                 = "reddit-app-template"
  description          = "This template is used to create app server instances."
  tags                 = ["puma-server", "reddit-app"]
  instance_description = "description assigned to instances"
  machine_type         = "f1-micro"
  can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    source_image = "reddit-full"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "default"
  }

  service_account {
    scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }
}

resource "google_compute_target_pool" "reddit-pool" {
  name   = "reddit-app-pool"
  region = "europe-west1"
}

resource "google_compute_health_check" "reddit-autohealing" {
  name                = "autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10                         # 50 seconds

  http_health_check {
    request_path = "/healthz"
    port         = "9292"
  }
}

resource "google_compute_instance_group_manager" "reddit-app-igm" {
  name               = "reddit-app-igm"
  base_instance_name = "reddi-base-app"
  instance_template  = "${google_compute_instance_template.reddit-app-template.self_link}"
  target_pools       = ["${google_compute_target_pool.reddit-pool.self_link}"]
  zone               = "europe-west1-b"

  auto_healing_policies {
    health_check      = "${google_compute_health_check.reddit-autohealing.self_link}"
    initial_delay_sec = 300
  }
}

resource "google_compute_autoscaler" "reddit-pool" {
  name   = "reddit-app-scaler"
  zone   = "europe-west1-b"
  target = "${google_compute_instance_group_manager.reddit-app-igm.self_link}"

  autoscaling_policy = {
    max_replicas    = 1
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}

resource "google_compute_forwarding_rule" "default" {
  name       = "puma-fwd-rule"
  target     = "${google_compute_target_pool.reddit-pool.self_link}"
  port_range = "9292"
  region     = "europe-west1"
}
