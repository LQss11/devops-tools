# Templates
You can create a template containing a set of multiple steps ad use on different pipelines.

## Example
### Same repo
**templates/template.yaml**
```yaml
steps:
- script: npm install
- script: npm test
- task: (task)
```
**pipeline.yaml**
```yaml
pool:
    vmImage:'ubuntu-latest'
steps:
    - template: templates/template.yaml
```
### Different repo
```yaml
pool:
    vmImage:'ubuntu-latest'
resources:
    repositories:
        - repository: templates-repo
        # github <identity/repo>
        # (azure devops) git <project>/<repo>
          type: github 
          name: <identitiy>/<repo>
steps:
    - template: template-file.yml@templates-repo
```