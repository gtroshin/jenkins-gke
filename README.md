# CI/CD Infrastructure on GCP with Jenkins

## Project Overview

This project establishes a scalable and automated CI/CD infrastructure on Google Cloud Platform (GCP) using Jenkins. The setup leverages Google Kubernetes Engine (GKE) for dynamic scaling of Jenkins agents, supporting both Linux and Windows (soon) build environments. The CI/CD pipeline can be triggered by code changes in Perforce or GitHub, with Jenkins managing the complete build, test, and deployment processes.

## Key Features

- **Dynamic Scaling**: Automatically scales Jenkins agents based on workload demands.
- **Multi-Environment Support**: Supports Linux builds, with plans for Windows support (soon).
- **Persistent Storage**: Ensures data persistence using PersistentVolumeClaims.

## Documentation

- **[Architecture Specification](docs/architecture.md)**: Detailed architecture overview and component descriptions.
- **[Setup Guide](docs/setup-guide.md)**: Step-by-step instructions for deploying the infrastructure.
