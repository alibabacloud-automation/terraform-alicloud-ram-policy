module "example" {
  source = "../../modules/EcsInstanceReboot"
  ecs_instance_ids = ["i-abcdefg1", "i-abcdefg2"]
}