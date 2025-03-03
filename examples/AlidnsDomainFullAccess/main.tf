resource "random_integer" "suffix" {
  min = 0
  max = 99999
}

module "example" {
  source             = "../../modules/AlidnsDomainFullAccess"
  alidns_domains     = ["domain1", "domain2"]
  policy_name_suffix = random_integer.suffix.result
}
