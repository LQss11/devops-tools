# Terraformer

**Terraformer** is a reverse Infrastructure as Code (IAC) tool that allows you to import existing infrastructure into HCL (HashiCorp Configuration Language) code.

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

You are now ready to use Terraformer with additional providers.