### Copyright (c) 2022, Oracle and/or its affiliates.
### All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
### Upload artifact stage for build pipeline.

resource "oci_devops_build_pipeline_stage" "test_deliver_artifact_stage" {
  depends_on = [oci_devops_build_pipeline_stage.test_build_pipeline_stage]
  build_pipeline_id         = oci_devops_build_pipeline.test_build_pipeline.id
  build_pipeline_stage_type = var.build_pipeline_stage_deliver_artifact_stage_type
  defined_tags              = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
  display_name              = var.deliver_artifact_stage_display_name
  freeform_tags             = {}

  build_pipeline_stage_predecessor_collection {
    items {
      id = oci_devops_build_pipeline_stage.test_build_pipeline_stage.id
    }
  }

  deliver_artifact_collection {
    items {
      artifact_id   = oci_devops_deploy_artifact.devops_app_executable.id
      artifact_name = "app_native_executable"
    }
    items {
      artifact_id   = oci_devops_deploy_artifact.devops_instance_deploy_spec.id
      artifact_name = "deployment_spec"
    }
  }

  timeouts {}
}

