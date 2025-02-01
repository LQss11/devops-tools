# Terraformer

**Terraformer** is a reverse Infrastructure as Code (IAC) tool that allows you to import existing infrastructure into HCL (HashiCorp Configuration Language) code.

# Quick start
```sh
terraformer import datadog --resources=synthetics_private_location --api-key ******** --app-key ******** --api-url https://api.datadoghq.com
```
Once dir generated with all imported resources you can go there and then make sure to use terraform `v0.13.0` but you can also try this workaround:
1. Replace **provider.tf** file content with this:
```hcl
terraform {
required_providers {
    datadog = {
    source = "DataDog/datadog"
    version = "~> 3.49.0"
    }
}
}
```
2. Update the provider from state
```sh
terraform state replace-provider -- -/datadog DataDog/datadog
terraform init
terraform output
```

## Installation

To install Terraformer on Windows, use the following command:

```sh
choco install terraformer
```

## Adding Providers

By default, only the AWS provider is included when running `terraformer import`. To add more providers or enable all providers, follow the steps below:

1. **Download Providers**  
   Visit the Terraformer GitHub Releases page and download the provider(s) you need:
   - **All Providers**:  
     [terraformer-all-windows-amd64](https://github.com/GoogleCloudPlatform/terraformer/releases/download/0.8.24/terraformer-all-windows-amd64)
   - **Specific Provider (e.g., GCP)**:  
     [terraformer-gcp-windows-amd64](https://github.com/GoogleCloudPlatform/terraformer/releases/download/0.8.24/terraformer-gcp-windows-amd64)

2. **Replace Terraformer Executable**  
   After downloading, move the file to the following directory:  
   `C:\ProgramData\chocolatey\lib\terraformer\tools`  

   Replace the existing `terraformer.exe` file with the downloaded file.

3. **Add provider file for terraformer to use**
    You will need to add your provider (e,g: **terraform-provider-datadog_v3.49.0.exe**) under the following directory `C:\.terraform.d\plugins\windows_amd64`

You are now ready to use Terraformer with additional providers.