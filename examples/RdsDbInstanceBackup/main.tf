resource "random_integer" "suffix" {
  min = 0
  max = 99999
}

module "example" {
  source             = "../../modules/RdsDbInstanceBackup"
  rds_dbinstances    = ["db-abcdefghijk01", "db-abcdefghijk02"]
  policy_name_suffix = random_integer.suffix.result
}