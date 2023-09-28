# MLPerf™ Storage Benchmark Suite on GKE

This repository contains Deployment/Job yaml files for running [MLPerf™ Storage Benchmark Suite](https://github.com/mlcommons/storage) on Google Kubernetes Engine.

## Installation

Preinstall the following on your computer:
* Kubectl
* Terraform
* Gcloud

### Run benchmark workload as a Deployment

To interact with the tool, try commands, and test different configurations, you
can run the benchmark workload as a Deployment.

1. Use the Terraform template in `benchmark/platform` to provision a cluster with
   the setup you need to run the benchmark. The example yaml file is using the configuration with
```
enable_gcs_fuse_csi_driver=true
gcs_bucket=<your gcs bucket>
enable_cpu=true
cpu_machine_type=n1-standard-96
```
all the other configurations are as default

2. `cd benchmark/workloads/storage`

3. Edit and deploy the pv and pvc for your workload.

4. `cd benchmark/workloads/mlperf-storage`

5. Edit `deployment.yaml` with your test settings. Replace `spec.template.spec.containers.volumes.csi.bucketName`
   with your gcs bucket.

6. Run `kubectl apply -f deployment.yaml`

7. Run `kubectl get pods --namespace=perf` replace --namespace=<your name space> with
   your namespace. Example out put:
```
NAME                                 READY   STATUS    RESTARTS   AGE
mlperf-deployment-84bbcc6d4d-qtqzk   2/2     Running   0          45s
```

8. Run command with your pod name, container name and namespace.
```
kubectl exec -it mlperf-deployment-84bbcc6d4d-qtqzk -c mlperf --namespace=perf /bin/sh
```

9. Run  [MLPerf™ Storage Benchmark Suite](https://github.com/mlcommons/storage) commands

10. Delete the deployment after you done with your test
```
kubectl delete deployments.apps mlperf-deployment --namespace=perf
```

### Run benchmark workload as a Job

You can run the benchmark workload as a job to run it periodically for regular
performance testing purposes.

1. Use the Terraform template in `benchmark/platform` to provision a cluster with
   the setup you need to run the benchmark.The example yaml file is using the configuration with
```
enable_gcs_fuse_csi_driver=true
gcs_bucket=<your gcs bucket>
enable_cpu=true
cpu_machine_type=n1-standard-96
```
all the other configurations are as default

2. `cd benchmark/workloads/storage`

3. Edit and deploy the pv and pvc for your workload.

4. `cd benchmark/workloads/mlperf-storage`

5. Edit `job.yaml` with your test settings. Replace `spec.template.spec.containers.volumes.csi.bucketName`
   with your gcs bucket. Replace `spec.template.spec.containers.args` with your command. You can find example
   commands in [MLPerf™ Storage Benchmark Suite](https://github.com/mlcommons/storage)

6. Run `kubectl apply -f job.yaml`

7. Run `kubectl describe jobs.batch mlperf-job --namespace=perf` to check the job
   status. Replace --namespace=<your name space> with your namespace.

8. Your benchmark report is saved in the --results-dir directory. If you specify
   a path on the GKE node, use the `gcloud compute ssh <node name>` command to connect to the node
   and check the log. You can also specify the path with the GCS bucket that you mount
   to your pod, and then you can find the logs in your GCS bucket.

9. Delete the job when it completed.
```
kubectl delete deployments.apps mlperf-job --namespace=perf
```