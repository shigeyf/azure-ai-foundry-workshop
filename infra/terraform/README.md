# Deploy Azure AI Foundry Resources with Terraform

This folder contains Terraform scripts to deploy Azure AI Foundry resources. Terraform is an Infrastructure as Code (IaC) tool that allows you to define and provision infrastructure using a declarative configuration language.

## Prerequisites

Before deploying the resources, ensure you have the following:

1. **Terraform Installed**
   - Install Terraform from [Terraform's official website](https://www.terraform.io/downloads.html).
1. **Azure CLI Installed**
   - Install the Azure CLI from [Microsoft's official documentation](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).
1. **Azure Subscription**
   - Ensure you have an active Azure subscription.
1. **Service Principal** or Azure user account
   - Create a service principal (or an user account) with the necessary permissions to deploy resources in your Azure subscription.

## Deployment Steps

1. **Authenticate with Azure**

   ```bash
   az login --tenant <your_TENANT_ID>
   ```

   If using a service principal, authenticate using:

   ```bash
   az login --service-principal -u <APP_ID> -p <PASSWORD> --tenant <Tyour_ENANT_ID>
   ```

2. **Initialize Terraform**

   Navigate to a deployment folder and run:

   ```bash
   terraform init
   ```

3. **Plan the Deployment**

   Review the resources that will be created or modified:

   ```bash
   terraform plan -var-file="variables.tfvars"
   ```

4. **Apply the Deployment**:

   Deploy the resources to Azure:

   ```bash
   terraform apply -var-file="variables.tfvars"
   ```

   Confirm the deployment when prompted.

5. **Verify Deployment**:

   After the deployment completes, verify the resources in the Azure portal.

## Cleaning Up Resources

To destroy the resources created by Terraform, run:

```bash
terraform destroy -var-file="variables.tfvars"
```

or

```bash
terraform apply -destroy -var-file="variables.tfvars"
```

## Folder Structure

- `modules`: Terraform modules for Azure AI Foundry environment resources
  - `ai-foundry-core`: Azure AI Foundry Hub resource and required/optional resources.
  - `ai-foundry-services`: AI related services connected wtih AI Foundry environment
- `sandbox`: Deployment project for Sandbox environment of Azure AI Foundry

## Notes

- Ensure sensitive information such as client secrets and passwords are not hardcoded in the Terraform files. Use environment variables or a secure secrets management solution.
- Regularly update the Terraform provider and modules to the latest versions to ensure compatibility and security.

For more information, refer to the [Terraform documentation](https://www.terraform.io/docs).
