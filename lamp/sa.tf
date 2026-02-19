resource "yandex_iam_service_account" "lamp_sa" {
  name = "lamp-sa"
}

resource "yandex_resourcemanager_folder_iam_member" "sa_editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.lamp_sa.id}"
}
