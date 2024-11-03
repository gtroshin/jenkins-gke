# Architecture Specification for CI/CD Infrastructure on GCP with Jenkins

## Overview

This project sets up a highly automated and scalable CI/CD infrastructure on Google Cloud Platform (GCP) using Jenkins as the primary CI/CD tool. The infrastructure is designed to dynamically scale Jenkins agents based on workload demands, using Google Kubernetes Engine (GKE) to orchestrate auto-scaling, and to support both Linux and Windows (soon) build environments. The CI/CD pipeline can be triggered by code changes in Perforce or GitHub, with Jenkins managing the end-to-end build, test, and deployment workflows.

## Components of the Architecture

### 1. Google Kubernetes Engine (GKE) Cluster

* Cluster Configuration: The GKE cluster is configured in the main.tf file.
* Node Pools: The cluster includes a node pool for Linux builds, with auto-scaling enabled.
* Persistent Storage: A PersistentVolumeClaim (PVC) is used to provide storage for Jenkins's data, ensuring that job history, configuration, and other persistent data are retained across pod restarts or updates.

### 2. Jenkins Deployment

* Deployment Configuration: Jenkins is deployed as a Kubernetes deployment.
* Persistent Storage: A PersistentVolumeClaim is used to ensure data persistence.

### 3. Networking

* Service Configuration: Jenkins is exposed via a LoadBalancer service.
* Firewall Rules: Ensure that necessary ports are open for Jenkins and JNLP communication.
* Role and Role Binding: Configured to allow Jenkins to manage pods within the cluster.
