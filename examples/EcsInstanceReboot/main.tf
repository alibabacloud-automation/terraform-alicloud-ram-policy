resource "random_integer" "suffix" {
  min = 0
  max = 99999
}

module "example" {
  source             = "../../modules/EcsInstanceReboot"
  ecs_instance_ids   = ["i-abcdefg1", "i-abcdefg2"]
  policy_name_suffix = random_integer.suffix.result
}