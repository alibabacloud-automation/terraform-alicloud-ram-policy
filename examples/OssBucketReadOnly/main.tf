module "example" {
  source = "../../modules/OssBucketReadOnly"
  oss_bucket_name = "bkt1"
  oss_object_names = ["file1", "file2"]
}