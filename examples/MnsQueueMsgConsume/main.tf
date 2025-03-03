resource "random_integer" "suffix" {
  min = 0
  max = 99999
}

module "example" {
  source             = "../../modules/MnsQueueMsgConsume"
  mns_queues         = ["queue1", "queue2"]
  policy_name_suffix = random_integer.suffix.result
}