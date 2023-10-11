module "ccm" {
  source  = "harness-community/harness-ccm/aws"
  version = "0.1.2"

  # source = "../../terraform-aws-harness-ccm"

  s3_bucket_arn = "arn:aws:s3:::harness-solutions-architecture"

  #overwrite
  external_id   = "harness:891928451355:2HHvmuKbSyeBFbEMIEZhLg"
  # additional_external_ids = [
  #   "harness:891928451355:V2iSB2gRR_SxBs0Ov5vqCQ"
  # ]
  enable_billing          = true
  enable_events           = true
  enable_optimization     = true
  enable_governance       = true
  enable_commitment_read  = true
  enable_commitment_write = true
  # governance_policy_arns = [
  #   aws_iam_policy.delegate_aws_access.arn
  # ]
  governance_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
  prefix = "brandon-"
  secrets = [
    "arn:aws:secretsmanager:us-west-2:759984737373:secret:sa/ca-key.pem-HYlaV4",
    "arn:aws:secretsmanager:us-west-2:759984737373:secret:sa/ca-cert.pem-kq8HQl"
  ]
}

#https://registry.terraform.io/providers/harness/harness/latest/docs
resource "harness_platform_connector_awscc" "brandonharnessccm" {
  identifier = "brandonharnessccm"
  name       = "brandon-harness-ccm"

  account_id  = "759984737373"
  report_name = "solutions-architecture"
  s3_bucket   = "harness-solutions-architecture"
  features_enabled = ["OPTIMIZATION", "VISIBILITY", "BILLING",]
  cross_account_access {
    role_arn    = module.ccm.cross_account_role
    external_id = module.ccm.external_id
  }
}

# resource "harness_platform_connector_azure_cloud_cost" "azure-sales-ccm" {
#   identifier = "azuresalesccm"
#   name       = "azure-sales-ccm"

#   features_enabled = ["BILLING", "VISIBILITY", "OPTIMIZATION"]
#   tenant_id        = "b229b2bb-5f33-4d22-bce0-730f6474e906"
#   subscription_id  = "e8389fc5-0cb8-44ab-947b-c6cf62552be0"
#   billing_export_spec {
#     storage_account_name = "rileysnyderharnessio"
#     container_name       = "ccm"
#     directory_name       = "export"
#     report_name          = "rileysnyderharnessccm"
#     subscription_id      = "e8389fc5-0cb8-44ab-947b-c6cf62552be0"
#   }
# }

# resource "harness_platform_connector_azure_cloud_cost" "azure-sales-ccm-broken" {
#   identifier = "azuresalesccmbroken"
#   name       = "azure-sales-ccm-broken"

#   features_enabled = ["VISIBILITY", "OPTIMIZATION"]
#   tenant_id        = "b229b2bb-5f33-4d22-bce0-730f6474e906"
#   subscription_id  = "e8389fc5-0cb8-44ab-947b-c6cf62552be1"
# }