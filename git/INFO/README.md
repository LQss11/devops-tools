git checkout $(git rev-list --max-parents=0 HEAD)

```sh
# Git checkout by commit number
COMMIT_NUMBER=1
git checkout $(git log --oneline main | awk '{print $1}' | tail -n ${COMMIT_NUMBER} | head -n 1)
```