apiVersion: v1
kind: Pod
metadata:
  namespace: ${namespace}
  name: jupyter-notebook-server
  labels:
    app: jupyter-notebook-server
spec:
  containers:
  - name: jupyter-notebook-server
    image: jupyter/tensorflow-notebook:latest
    args: ["start-notebook.sh", "--NotebookApp.password='argon2:$argon2id$v=19$m=10240,t=10,p=8$1zOa5vwUaYQlPAcOCwQD9w$x2KByFJzFDdrt32pQ1Hvv/gImq5yqO2D136bJbuIfN8'"]
    env:
    - name: CHOWN_EXTRA
      value: /home/jovyan/filestore
    - name: CHOWN_EXTRA_OPTS
      value: '-R'
    securityContext:
      # runAsUser: 1000
      # runAsGroup: 100
      fsGroup: 100
    resources:
      limits:
        cpu: 1000m
        memory: 10Gi
        nvidia.com/gpu: "1"
      requests:
        cpu: 1000m
        memory: 10Gi
        nvidia.com/gpu: "1"
    ports:
    - containerPort: 8888
      name: http-web-svc
    volumeMounts:
    - name: filestore-pvc
      mountPath: /home/jovyan/filestore
  volumes:
  - name: filestore-pvc
    persistentVolumeClaim:
      claimName: filestore-ent-pvc