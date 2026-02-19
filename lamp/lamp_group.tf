resource "yandex_compute_instance_group" "lamp_group" {
  name               = "lamp-group"
  service_account_id = yandex_iam_service_account.lamp_sa.id

  instance_template {
    platform_id = "standard-v1"

    resources {
      cores  = 2
      memory = 2
    }

    boot_disk {
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        size     = 20
      }
    }

    network_interface {
      network_id = data.yandex_vpc_network.vpc.id
      subnet_ids = [data.yandex_vpc_subnet.public.id]
      nat        = true
    }

#     metadata = {
#       ssh-keys = "ubuntu:${var.ssh_public_key}"
#       user-data = <<EOF
# #!/bin/bash
# echo "<html><body><h1>LAMP OK</h1><img src='https://${var.bucket_name}.storage.yandexcloud.net/test.jpg'></body></html>" > /var/www/html/index.html
# EOF
#     }
#     metadata = {
#   ssh-keys = "ubuntu:${var.ssh_public_key}"

#   user-data = <<EOF
# #cloud-config
# runcmd:
#  - apt update
#  - apt install -y apache2
#  - systemctl enable apache2
#  - systemctl start apache2
#  - bash -c 'cat > /var/www/html/index.html <<HTML
# <html>
#   <body>
#     <h1>LAMP OK</h1>
#     <p>Image from Object Storage:</p>
#     <img src="https://${var.bucket_name}.storage.yandexcloud.net/myimage.jpg" width="500">
#   </body>
# </html>
# HTML'
# EOF
# }

metadata = {
  ssh-keys = "ubuntu:${var.ssh_public_key}"

  user-data = <<EOF
#cloud-config

write_files:
  - path: /var/www/html/index.html
    content: |
      <html>
        <body>
          <h1>LAMP OK</h1>
          <p>Image from Object Storage:</p>
          <img src="https://${var.bucket_name}.storage.yandexcloud.net/myimage.jpg" width="500">
        </body>
      </html>

runcmd:
  - systemctl restart apache2
EOF
}

  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 1
  }

  allocation_policy {
    zones = [var.zone]
  }

  health_check {
    http_options {
      port = 80
      path = "/"
    }
  }
}