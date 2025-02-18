module "example" {
  source = "../../modules/MnsQueueMsgConsume"
  mns_queues = ["queue1", "queue2"]
}