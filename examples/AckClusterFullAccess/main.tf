module "example" {
  source = "../../modules/AckClusterFullAccess"
  ack_clusters = ["cls1", "cls2"]
}