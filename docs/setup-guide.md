# Complete Deployment Steps

1. Apply Persistent Volume Claim:

Ensure the persistent volume claim is created for Jenkins data storage:

```bash
kubectl apply -f terraform/jenkins/jenkins-pvc.yaml
```

2. Apply Role and Role Binding:

Set up the necessary permissions for Jenkins to manage resources:

```bash
kubectl apply -f terraform/jenkins/jenkins-role.yaml
kubectl apply -f terraform/jenkins/jenkins-role-binding.yaml
```

3. Apply Jenkins Deployment and Service:

Deploy Jenkins and expose it via a LoadBalancer:

```bash
kubectl apply -f terraform/jenkins/jenkins-deployment.yaml
kubectl apply -f terraform/jenkins/jenkins-service.yaml
```
