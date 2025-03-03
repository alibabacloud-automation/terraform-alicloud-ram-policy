resource "random_integer" "suffix" {
  min = 0
  max = 99999
}

module "example" {
  source             = "../../modules/CrRepositoryFullAccess"
  cr_namespace       = "ns1"
  cr_repositories    = ["repo1", "repo2"]
  policy_name_suffix = random_integer.suffix.result
}