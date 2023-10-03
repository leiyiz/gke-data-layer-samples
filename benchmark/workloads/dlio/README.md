# Deep Learning I/O (DLIO) Benchmark on GKE

This repository contains Deployment/Job yaml files for running [Deep Learning I/O (DLIO) Benchmark](https://github.com/argonne-lcf/dlio_benchmark) on Google Kubernetes Engine.

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
cpu_machine_type=n2-highmem-128
```
all the other configurations are as default

2. `cd benchmark/workloads/storage`

3. Edit and deploy the pv and pvc for your workload.

4. `cd benchmark/workloads/dlio`

5. Edit `deployment.yaml` with your test settings. Replace `spec.template.spec.containers.volumes.csi.bucketName`
   with your gcs bucket.

6. Run `kubectl apply -f deployment.yaml`

7. Run `kubectl get pods --namespace=perf` replace --namespace=<your name space> with
   your namespace. Example out put:
```
NAME                                 READY   STATUS    RESTARTS   AGE
dlio-deployment-6cbfb88f6c-2fkwk   2/2     Running   0            8s
```

8. Run command with your pod name, container name and namespace.
```
kubectl exec -it dlio-deployment-6cbfb88f6c-2fkwk  -c dlio --namespace=perf /bin/sh
```

9. Run [Deep Learning I/O (DLIO) Benchmark](https://github.com/argonne-lcf/dlio_benchmark) commands

10. Delete the deployment after you done with your test
```
kubectl delete deployments.apps dlio-deployment --namespace=perf
```

### Run benchmark workload as a Job

You can run the benchmark workload as a job to run it periodically for regular
performance testing purposes. This method also automates test running and data collection.

1. Use the Terraform template in `benchmark/platform` to provision a cluster with
   the setup you need to run the benchmark.The example yaml file is using the configuration with
```
enable_gcs_fuse_csi_driver=true
gcs_bucket=<your gcs bucket>
enable_cpu=true
cpu_machine_type=n2-highmem-128
```
all the other configurations are as default

2. `cd benchmark/workloads/storage`

3. Edit and deploy the pv and pvc for your workload.

4. `cd benchmark/workloads/dlio`

5. Edit `job.yaml` with your test settings. Replace `spec.template.spec.containers.volumes.csi.bucketName`
   with your gcs bucket. Replace `spec.template.spec.containers.env` with appropriate test configuration.

6. Run `kubectl apply -f job.yaml`

7. Run `kubectl describe jobs.batch dlio-job --namespace=perf` to check the job
   status. Replace --namespace=<your name space> with your namespace.

8. Your benchmark report is saved in the `${DATA_MOUNT}/${BENCHMARK_RESULT}` directory. If you specify
   a path on the GKE node, use the `gcloud compute ssh <node name>` command to connect to the node
   and check the log. You can also specify the path with the GCS bucket that you mount
   to your pod, and then you can find the logs in your GCS bucket.

9. Delete the job when it completed.
```
kubectl delete deployments.apps dlio-job --namespace=perf
```