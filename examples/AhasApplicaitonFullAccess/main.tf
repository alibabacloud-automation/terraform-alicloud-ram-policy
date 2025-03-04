resource "random_integer" "suffix" {
  min = 0
  max = 99999
}

module "example" {
  source             = "../../modules/AhasApplicaitonFullAccess"
  ahas_namespace     = "ns1"
  ahas_applications  = ["app1", "app2"]
  policy_name_suffix = random_integer.suffix.result
}