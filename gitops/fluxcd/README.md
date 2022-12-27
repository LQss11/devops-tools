# Fluxcd
Make sure the version you install is [compatible](https://fluxcd.io/flux/installation/) with k8s version 

```sh
choco install flux
. <(flux completion bash)
docker pull fluxcd/flux:1.25.4
docker pull fluxcd/flux-cli:v0.38.2
```

Make sure to create token in github ([link](https://github.com/settings/tokens))
```sh

export GITHUB_TOKEN=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
export GITHUB_USER=LQss11
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=devops-tools \
  --branch=main \
  --path=./gitops/fluxcd/manifests \
  --personal
```

[Uninstall to Change path](https://github.com/fluxcd/flux2/issues/2751#issuecomment-1135768196):
```sh
flux uninstall --keep-namespace 
```