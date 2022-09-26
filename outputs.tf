## Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl



output "Generated_ssh_private_key" {
  value     = tls_private_key.public_private_key_pair.private_key_pem
  sensitive = true
}

output "Loadbalacer_public_ip" {
  value = oci_load_balancer_load_balancer.test_load_balancer.ip_addresses[0]
}

output "Dev" {
  value = "Made with \u2764 by Oracle Developers"
}

output "Validate" {
  value = "Use OCI Devops > Project > Build pipeline > Start a manual Run, Wait for Build and Deployment stages to complete,Launch the application using http://${oci_load_balancer_load_balancer.test_load_balancer.ip_addresses[0]}:8080"
}