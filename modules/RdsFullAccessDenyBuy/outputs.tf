output "policy_json" {
  description = "Policy document as json. Useful if you need document but do not want to create IAM policy itself. For example for CloudSSO Permission Set inline policies"
  value       = local.policy_json
}

output "id" {
  description = "The policy's ID"
  value       = try(alicloud_ram_policy.policy[0].id, "")
}

output "description" {
  description = "The description of the policy"
  value       = try(alicloud_ram_policy.policy[0].description, "")
}

output "policy_name" {
  description = "The name of the policy"
  value       = try(alicloud_ram_policy.policy[0].policy_name, "")
}

output "policy_document" {
  description = "The policy document"
  value       = try(alicloud_ram_policy.policy[0].policy_document, "")
}
