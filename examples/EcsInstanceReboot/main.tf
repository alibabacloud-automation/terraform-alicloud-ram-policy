terraform {
  required_version = ">= 1.0"

  required_providers {
    alicloud = {
      source = "aliyun/alicloud"
      version = ">= 1.220.0"
    }
  }
}

module "example" {
  source = "../../modules/EcsInstanceReboot"
  ecs_instance_ids = ["i-abcdefg1", "i-abcdefg2"]
}
