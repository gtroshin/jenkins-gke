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

## Managing Plugins

To update or add new plugins:

1. Edit the plugins.txt file with your desired plugins
2. Update the plugins ConfigMap:
```bash
kubectl delete configmap jenkins-plugins
kubectl create configmap jenkins-plugins --from-file=plugins.txt=terraform/jenkins/plugins.txt
```

3. Restart Jenkins to apply changes:
```bash
kubectl delete pod $(kubectl get pods -l app=jenkins -o jsonpath='{.items[0].metadata.name}')
```

## Managing Cloud Agents

To update Kubernetes cloud configuration:

1. Edit the jenkins-configuration-configmap.yaml file with your desired cloud settings
2. Apply the updated configuration:
```bash
kubectl delete configmap jenkins-configuration
kubectl apply -f terraform/jenkins/jenkins-configuration-configmap.yaml
```

3. Restart Jenkins to apply changes:
```bash
kubectl delete pod $(kubectl get pods -l app=jenkins -o jsonpath='{.items[0].metadata.name}')
```

### Common Cloud Agent Configurations

1. To add a new agent template:
   - Edit jenkins-configuration-configmap.yaml
   - Add a new template under the `templates` section
   - Include container configurations, labels, and resource limits

2. To modify existing agent template:
   - Update the template configuration in jenkins-configuration-configmap.yaml
   - Apply changes using the steps above

3. To verify agent configuration:
   - Access Jenkins UI
   - Navigate to Manage Jenkins > Nodes and Clouds
   - Select Configure Clouds
   - Verify Kubernetes cloud settings

Note: After making changes to cloud configurations, test the setup by running a simple pipeline job to ensure agents can be provisioned correctly.
