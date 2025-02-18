module "example" {
  source = "../../modules/PostLogToSlsProject"
  sls_project = "prj1"
  sls_logstores = ["logstore1", "logstore2"]
}