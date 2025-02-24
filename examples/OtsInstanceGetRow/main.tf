module "example" {
  source = "../../modules/OtsInstanceGetRow"
  ots_instance = "inst1"
  ots_tables = ["tbl1", "tbl2"]
}