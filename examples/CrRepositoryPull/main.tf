resource "random_integer" "suffix" {
  min = 0
  max = 99999
}

module "example" {
  source             = "../../modules/CrRepositoryPull"
  cr_namespace       = "ns1"
  policy_name_suffix = random_integer.suffix.result
}