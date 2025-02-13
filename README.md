# Cloudmart E-commerce

Cloudmart E-commerce is a full-stack e-commerce application that leverages AWS DynamoDB for data storage, a Node.js backend API, and a modern frontend application. This repository includes:

- **Terraform:** Infrastructure-as-Code to provision three DynamoDB tables: `cloudmart-orders`, `cloudmart-products`, and `cloudmart-users`.
- **Backend:** The server-side application that connects to DynamoDB and exposes RESTful APIs.
- **Frontend:** The client-side application that consumes the backend APIs.
- **Docker:** Containerization for both backend and frontend to ensure consistent deployment environments.

---

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation and Setup](#installation-and-setup)
  - [1. Cloning the Repository](#1-cloning-the-repository)
  - [2. Provisioning with Terraform](#2-provisioning-with-terraform)
  - [3. Configuring the Backend](#3-configuring-the-backend)
  - [4. Configuring the Frontend](#4-configuring-the-frontend)
  - [5. Running the Docker Containers](#5-running-the-docker-containers)
- [Usage](#usage)
- [Environment Variables](#environment-variables)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

---

## Overview

This project uses Terraform to create the necessary DynamoDB tables on AWS and Docker to containerize both the backend and frontend applications. It is crucial that your AWS credentials are correctly configured in your environment to ensure successful provisioning of resources.

## Architecture

- **Terraform:** Manages the provisioning of DynamoDB tables.
- **Backend:** A Node.js service that connects to DynamoDB and exposes APIs.
- **Frontend:** A web application that interacts with the backend API.
- **Docker:** Provides containerization to guarantee a consistent runtime environment across development and production.

## Features

- Provision AWS resources using Terraform.
- Deploy backend and frontend applications in Docker containers.
- Clear separation of concerns for easier maintenance and scalability.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed.
- An [AWS](https://aws.amazon.com/) account with permissions to create the required resources.
- [Docker](https://www.docker.com/get-started) installed.
- [Git](https://git-scm.com/downloads) installed.

## Installation and Setup

### 1. Cloning the Repository

Clone the repository and navigate to the project directory:

```bash
git https://github.com/BrunoChiconato/terraform-project.git
cd terraform-project
```

### 2. Provisioning with Terraform

In the root directory of the project, initialize and apply the Terraform configuration to create the DynamoDB tables:

```bash
terraform init
terraform plan
terraform apply
```

> **Note:** Ensure your AWS credentials are properly configured (e.g., via environment variables or AWS credentials file) before running these commands.

### 3. Configuring the Backend

Navigate to the `backend` directory:

```bash
cd backend
```

1. **Update the `.env` file** with your AWS credentials and other required variables:

    ```env
    PORT=5000
    AWS_ACCESS_KEY_ID=YOUR_AWS_ACCESS_KEY
    AWS_SECRET_ACCESS_KEY=YOUR_AWS_SECRET_KEY
    AWS_REGION=us-east-1
    BEDROCK_AGENT_ID=YOUR_BEDROCK_AGENT_ID
    BEDROCK_AGENT_ALIAS_ID=YOUR_BEDKROCK_AGENT_ALIAS_ID
    OPENAI_API_KEY=YOUR_OPENAI_API_KEY
    OPENAI_ASSISTANT_ID=YOUR_ASSISTANT_ID
    ```

2. **Build the Docker image** for the backend:

   ```bash
   docker build -t cloudmart-backend .
   ```

### 4. Configuring the Frontend

Navigate to the `frontend` directory:

```bash
cd ../frontend
```

1. **Update the `.env` file** with the API URL for the backend. For local development, use:

   ```env
   VITE_API_BASE_URL=http://localhost:5000/api
   ```

2. **Build the Docker image** for the frontend:

   ```bash
   docker build -t cloudmart-frontend .
   ```

### 5. Running the Docker Containers

1. **Create a Docker network** to allow communication between the containers:

   ```bash
   docker network create cloudmart-network
   ```

2. **Run the Backend container:**

   ```bash
   docker run -d \
     --name cloudmart-backend \
     --network cloudmart-network \
     --env-file .env \
     -p 5000:5000 \
     cloudmart-backend
   ```

3. **Run the Frontend container:**

   ```bash
   docker run -d \
     --name cloudmart-frontend \
     --network cloudmart-network \
     -p 5001:5001 \
     cloudmart-frontend
   ```

## Usage

- Access the frontend application at: [http://localhost:5001](http://localhost:5001)
- To manage product listings, navigate to the admin area at: [http://localhost:5001/admin](http://localhost:5001/admin)
