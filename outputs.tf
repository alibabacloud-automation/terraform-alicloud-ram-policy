output "this_policy_id" {
  description = "Id of the custom policy."
  value       = alicloud_ram_policy.policy_with_actions.*.id
}
output "this_policy_name" {
  description = "Name of the custom policy."
  value       = alicloud_ram_policy.policy_with_actions.*.name
}