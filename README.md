\# NationWall Azure Terraform CI/CD – Project 3



\## Project Overview



This project demonstrates a secure Infrastructure-as-Code CI/CD pipeline for Microsoft Azure using Terraform, GitHub Actions, and Microsoft Entra ID workload identity federation.



The pipeline automatically validates and plans Terraform changes, while production infrastructure changes require a controlled approval before Terraform Apply.



\## Architecture



Developer

↓

GitHub Repository

↓

GitHub Actions

↓

Terraform Format / Validate / Plan

↓

Azure OIDC Authentication

↓

Terraform Remote State

↓

Production Approval

↓

Terraform Apply

↓

Azure Infrastructure



\## Technologies Used



\- Microsoft Azure

\- Terraform 1.16.0

\- AzureRM Terraform Provider

\- GitHub Actions

\- GitHub Environments

\- Microsoft Entra ID

\- Workload Identity Federation / OIDC

\- Azure Storage Blob remote state

\- Git

\- PowerShell



\## Azure Infrastructure



Terraform deployed the following infrastructure:



\- Resource Group: rg-nationwall-project3

\- Virtual Network: vnet-nationwall-project3

\- Subnet: snet-application

\- Network Security Group: nsg-nationwall-project3

\- NSG/Subnet association

\- Storage Account: nwproject3tf20260923



All resources were deployed in the current Azure subscription.



\## Terraform Remote State



Terraform state is stored remotely in Azure Blob Storage.



Backend:



\- Resource Group: rg-nationwall-dev-001

\- Storage Account: stnationwalltf001

\- Container: tfstate

\- State file: nationwall-project3.tfstate



Remote state prevents the GitHub Actions runners from relying on local Terraform state.



\## CI/CD Pipeline



The GitHub Actions workflow performs the following steps:



1\. Checkout repository

2\. Install Terraform 1.16.0

3\. Authenticate to Azure using OIDC

4\. Run Terraform format check

5\. Initialize Terraform

6\. Validate Terraform configuration

7\. Generate Terraform plan

8\. Store the Terraform plan as an artifact

9\. Wait for production approval

10\. Apply the approved Terraform plan



\## Secure Azure Authentication



The pipeline uses GitHub Actions OIDC instead of storing an Azure client secret in GitHub.



GitHub Actions receives a short-lived identity token which is trusted by a Microsoft Entra federated identity credential attached to the managed identity:



`nationwall-github-oidc`



GitHub repository secrets contain only the required Azure identifiers:



\- AZURE\_CLIENT\_ID

\- AZURE\_TENANT\_ID

\- AZURE\_SUBSCRIPTION\_ID



No client secret is stored in the repository.



\## Controlled Production Deployment



The Terraform Apply job is protected by the GitHub `production` environment.



A manual approval is required before Terraform Apply can execute.



This provides a separation between:



Plan → Review → Approval → Apply



\## Branch Protection



The `main` branch is protected using a GitHub ruleset.



The ruleset includes:



\- Pull request requirement

\- Required Terraform Plan status check

\- Force-push protection

\- Branch deletion protection



This prevents unreviewed changes from being directly introduced into the protected branch.



\## CI Failure Test



A temporary `failure-test` branch was created with an intentionally invalid Terraform file.



The pull request triggered GitHub Actions and failed during:



`Terraform Format Check`



This demonstrated that the CI pipeline detects invalid Terraform changes before they can reach the protected `main` branch.



The test pull request was closed without merging and the temporary branch was deleted.



\## Security Controls



The project demonstrates:



\- OIDC authentication

\- No long-lived Azure client secret

\- GitHub repository secrets

\- Remote Terraform state

\- Production approval

\- Protected main branch

\- Required CI status checks

\- Controlled Terraform Apply



\## Project Outcome



The completed pipeline demonstrates an end-to-end Terraform CI/CD workflow:



Terraform Code

→ GitHub

→ GitHub Actions

→ Validation

→ Terraform Plan

→ Approval

→ Terraform Apply

→ Azure Infrastructure



The project provides practical evidence of Infrastructure as Code, CI/CD automation, Azure administration, GitHub Actions, identity federation, and deployment controls.

