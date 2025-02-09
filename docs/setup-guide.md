# Complete Deployment Steps

## Prerequisites

First, initialize and apply the Terraform configuration to create the GKE cluster:

```bash
terraform -chdir=terraform init
terraform -chdir=terraform apply
```

After the cluster is created, configure kubectl to use the new cluster:

```bash
gcloud container clusters get-credentials jenkins-cluster --zone us-central1-a --project jenkins-k8s-demo
```

## Jenkins Deployment Steps

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

3. Create Jenkins Configuration:

Apply the Configuration-as-Code for Jenkins cloud configuration:

```bash
kubectl apply -f terraform/jenkins/jenkins-configuration-configmap.yaml
```

4. Create Plugins Configuration:

Create ConfigMap for Jenkins plugins:

```bash
kubectl create configmap jenkins-plugins --from-file=plugins.txt=terraform/jenkins/plugins.txt
```

5. Apply Jenkins Deployment and Service:

Deploy Jenkins and expose it via a LoadBalancer:

```bash
kubectl apply -f terraform/jenkins/jenkins-deployment.yaml
kubectl apply -f terraform/jenkins/jenkins-service.yaml
```

6. Access Jenkins:

Get the LoadBalancer IP:

```bash
kubectl get svc jenkins
```

Access Jenkins UI at http://<EXTERNAL-IP>:8080

The initial admin password can be found by running:

```bash
kubectl exec -it $(kubectl get pods -l app=jenkins -o jsonpath='{.items[0].metadata.name}') -- cat /var/jenkins_home/secrets/initialAdminPassword
```
