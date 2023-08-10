kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: filestore-ent-pvc
  namespace: ${namespace}
spec:
  accessModes:
    - ReadWriteMany
  volumeMode: Filesystem
  storageClassName: ${storageclass}
  resources:
    requests:
      storage: 1Ti