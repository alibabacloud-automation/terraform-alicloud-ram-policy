module "example" {
  source = "../../modules/AlidnsDomainFullAccess"
  alidns_domains = ["domain1", "domain2"]
}
