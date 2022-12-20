# Docker Secret
You can secure credentials in dockerfile
```sh
docker build --no-cache --progress=plain --secret id=mysecret,src=mysecret.txt -t mysecretimage .
```