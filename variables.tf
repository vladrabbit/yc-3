variable "cloud_id" {
  description = "ID облака Yandex Cloud"
}

variable "folder_id" {
  description = "ID папки Yandex Cloud"
}

variable "zone" {
  description = "Зона Yandex Cloud"
  default     = "ru-central1-a"
}

variable "ssh_public_key" {
  description = "Публичный SSH ключ для доступа к VM"
}

