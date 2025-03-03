resource "random_integer" "suffix" {
  min = 0
  max = 99999
}

module "example" {
  source             = "../../modules/OtsInstanceGetRow"
  ots_instance       = "inst1"
  ots_tables         = ["tbl1", "tbl2"]
  policy_name_suffix = random_integer.suffix.result
}