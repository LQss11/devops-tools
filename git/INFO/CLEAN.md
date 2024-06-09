# Git remove commit 'clean unwanted commit'
## Local
```sh
git rm --cached filename
git reset HEAD^

git commit --amend -m "aaa"
```
## Remote
```sh
git reset --hard #commitSHA

git push --force

```
All commits after that commit SHA will be deleted

```sh
git filter-branch
git filter-repo
BFG Repo cleaner
```

# Undo last commit
```sh
git reset --soft HEAD~
```