# resource "yandex_storage_bucket" "lamp_bucket" {
#   bucket = var.bucket_name
#   acl    = "public-read"
# }

resource "yandex_storage_bucket" "lamp_bucket" {
  bucket    = var.bucket_name
  folder_id = var.folder_id

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.bucket_key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}
