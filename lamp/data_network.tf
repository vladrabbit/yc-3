data "yandex_vpc_network" "vpc" {
  name = "demo-vpc"
}

data "yandex_vpc_subnet" "public" {
  name = "public"
}