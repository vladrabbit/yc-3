resource "yandex_lb_target_group" "lamp_tg" {
  name = "lamp-target-group"

  dynamic "target" {
    for_each = yandex_compute_instance_group.lamp_group.instances
    content {
      subnet_id = target.value.network_interface[0].subnet_id
      address   = target.value.network_interface[0].ip_address
    }
  }
}

resource "yandex_lb_network_load_balancer" "lamp_nlb" {
  name = "lamp-nlb"

  listener {
    name = "http"
    port = 80
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.lamp_tg.id

    healthcheck {
      name = "http-check"

      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
