module "example" {
  source = "../../modules/RdsDbInstanceBackup"
  rds_dbinstances = ["db-abcdefghijk01", "db-abcdefghijk02"]
}