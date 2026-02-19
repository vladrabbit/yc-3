resource "yandex_kms_symmetric_key" "bucket_key" {
  name              = "bucket-key"
  description       = "KMS key for Object Storage encryption"
  default_algorithm = "AES_256"
  rotation_period   = "8760h"
}

# resource "yandex_kms_symmetric_key_iam_binding" "kms_use" {
#   symmetric_key_id = yandex_kms_symmetric_key.bucket_key.id
#   role             = "kms.keys.encrypterDecrypter"

#   members = [
#     "serviceAccount:${yandex_iam_service_account.lamp_sa.id}"
#   ]
# }
