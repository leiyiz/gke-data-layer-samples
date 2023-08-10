apiVersion: v1
kind: Service
metadata:
  namespace: ${namespace}
  name: jupyter-notebook-server
spec:
  selector:
    app: jupyter-notebook-server
  ports:
  - name: name-of-service-port
    protocol: TCP
    port: 8888
    targetPort: http-web-svc
  type: LoadBalancer