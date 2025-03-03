resource "random_integer" "suffix" {
  min = 0
  max = 99999
}

module "example" {
  source             = "../../modules/PostLogToSlsProject"
  sls_project        = "prj1"
  sls_logstores      = ["logstore1", "logstore2"]
  policy_name_suffix = random_integer.suffix.result
}