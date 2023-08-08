# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

resource "local_file" "podspec" {
  content = templatefile("${path.module}/podspec.tpl", {
    namespace = "${var.namespace}"
    gcs_bucket = "${var.gcs_bucket}"
    service_account = "${var.k8s_service_account}"
  })
  filename = "${path.module}/pod-spec-rendered.yaml"
}

resource "kubectl_manifest" "podspec" {
  yaml_body          = resource.local_file.podspec.content
}
