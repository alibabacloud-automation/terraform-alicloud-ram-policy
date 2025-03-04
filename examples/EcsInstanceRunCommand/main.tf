resource "random_integer" "suffix" {
  min = 0
  max = 99999
}

module "example" {
  source             = "../../modules/EcsInstanceRunCommand"
  policy_name_suffix = random_integer.suffix.result
}