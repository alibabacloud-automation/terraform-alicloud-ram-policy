resource "random_integer" "suffix" {
  min = 0
  max = 99999
}

module "example" {
  source             = "../../modules/NetworkAdministrator"
  policy_name_suffix = random_integer.suffix.result
}