### Copyright (c) 2022, Oracle and/or its affiliates.
### All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
### Deploy to instances.

resource "oci_devops_deploy_stage" "deploy_to_instances" {
  compute_instance_group_deploy_environment_id = oci_devops_deploy_environment.prod_deploy_environment.id
  defined_tags                                 = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
  deploy_artifact_ids                          = []
  deploy_pipeline_id                           = oci_devops_deploy_pipeline.test_deploy_pipeline.id
  deploy_stage_type                            = var.deploy_stage_type
  deployment_spec_deploy_artifact_id           = oci_devops_deploy_artifact.devops_instance_deploy_spec.id
  description                                  = var.deploy_description
  display_name                                 = var.deploy_display_name
  freeform_tags                                = {}

  deploy_stage_predecessor_collection {
    items {
      id = oci_devops_deploy_pipeline.test_deploy_pipeline.id
    }
  }

  failure_policy {
    failure_count      = var.deploy_failure_count
    failure_percentage = 0
    policy_type        = "COMPUTE_INSTANCE_GROUP_FAILURE_POLICY_BY_COUNT"
  }

  load_balancer_config {
    backend_port     = var.deploy_backend_port
    listener_name    = oci_load_balancer_listener.test_listener.name
    load_balancer_id = oci_load_balancer_load_balancer.test_load_balancer.id
  }

  rollback_policy {
    policy_type = "NO_STAGE_ROLLBACK_POLICY"
  }

  rollout_policy {
    batch_count            = var.deploy_batch_count
    batch_delay_in_seconds = var.deploy_batch_delay_in_seconds
    batch_percentage       = 0
    policy_type            = "COMPUTE_INSTANCE_GROUP_LINEAR_ROLLOUT_POLICY_BY_COUNT"
    ramp_limit_percent     = 0
  }

  timeouts {}
}

