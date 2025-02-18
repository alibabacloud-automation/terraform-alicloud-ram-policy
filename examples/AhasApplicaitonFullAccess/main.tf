module "example" {
  source = "../../modules/AhasApplicaitonFullAccess"
  ahas_namespace = "ns1"
  ahas_applications = ["app1", "app2"]
}