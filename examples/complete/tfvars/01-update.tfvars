###################################################################
# ram policy with default actions used to to manage ecs Instance  #
###################################################################

ecs_defined_actions = "instance-all,vpc-all,security-group-rule-all"
effect = "Deny"
force  =  true

###############################################################
# ram policy with custom actions used to to manage OSS bucket #
###############################################################
oss_bucket_actions = "oss:PutBucket*,DeleteBucket*"
oss_bucket_resources = "acs:oss:*:*:mybucket"

#################################################################################
# ram policy with bosh defined and custom actions used to to manage slb and eip #
#################################################################################

slb_eip_defined_actions = "slb-all,vswitch-all"
slb_eip_actions = "vpc:AssociateEipAddress"
slb_eip_resources = "acs:vpc:*:*:eip/eip-123,acs:slb:*:*:*"
