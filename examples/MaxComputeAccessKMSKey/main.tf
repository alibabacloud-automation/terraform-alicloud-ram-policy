module "example" {
  source = "../../modules/MaxComputeAccessKMSKey"
  kms_key_id = "key-111"
  kms_key_region = "cn-hangzhou"
  kms_key_account = "1234567890"
}