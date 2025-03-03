output "policy_json" {
  description = "Policy document as json. Useful if you need document but do not want to create IAM policy itself. For example for CloudSSO Permission Set inline policies"
  value       = module.example.policy_json
}

output "id" {
  description = "The policy's ID"
  value       = module.example.id
}

output "description" {
  description = "The description of the policy"
  value       = module.example.description
}

output "policy_name" {
  description = "The name of the policy"
  value       = module.example.policy_name
}

output "policy_document" {
  description = "The policy document"
  value       = module.example.policy_document
}
