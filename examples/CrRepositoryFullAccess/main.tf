module "example" {
  source = "../../modules/CrRepositoryFullAccess"
  cr_namespace = "ns1"
  cr_repositories = ["repo1", "repo2"]
}