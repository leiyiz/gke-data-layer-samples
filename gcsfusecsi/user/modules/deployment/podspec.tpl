apiVersion: apps/v1
kind: Deployment
metadata:
  name: gcp-gcs-csi-ephemeral-example
  namespace: ${namespace}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: gcp-gcs-csi-ephemeral-example
  template:
    metadata:
      labels:
        app: gcp-gcs-csi-ephemeral-example
      annotations:
        gke-gcsfuse/volumes: "true"
    spec:
      containers:
      - name: writer
        image: alpine
        resources:
          limits:
            cpu: 100m
            memory: 100Mi
            nvidia.com/gpu: "1"
          requests:
            cpu: 10m
            memory: 80Mi
            nvidia.com/gpu: "1"
        command:
          - "/bin/sh"
          - "-c"
          - touch /data/datefile.log && while true; do echo $(date) >> /data/datefile; sleep 1; done
        env:
          - name: MY_POD_NAME
            valueFrom:
              fieldRef:
                fieldPath: metadata.name
        volumeMounts:
        - name: gcp-gcs-csi-ephemeral
          mountPath: /data
      serviceAccountName: ${service_account}
      volumes:
      - name: gcp-gcs-csi-ephemeral
        csi:
          driver: gcsfuse.csi.storage.gke.io
          volumeAttributes:
            bucketName: ${gcs_bucket}