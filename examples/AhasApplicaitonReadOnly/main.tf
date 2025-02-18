module "example" {
  source = "../../modules/AhasApplicaitonReadOnly"
  ahas_namespace = "ns1"
  ahas_applications = ["app1", "app2"]
}