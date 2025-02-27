#!/usr/bin/env bash

# Copyright 2018 The Kubernetes Authors.
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

source "$(dirname "$0")/../common.sh"
source "$(dirname "$0")/setup.sh"

export KIND_CLUSTER="local-kubebuilder-e2e"
create_cluster ${KIND_K8S_VERSION:-v1.18.15}
if [ -z "${SKIP_KIND_CLEANUP:-}" ]; then
  trap delete_cluster EXIT
fi

kind export kubeconfig --kubeconfig $tmp_root/kubeconfig --name $KIND_CLUSTER
export KUBECONFIG=$tmp_root/kubeconfig

test_cluster -v -ginkgo.v
