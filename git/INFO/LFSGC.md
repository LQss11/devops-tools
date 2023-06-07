# Git LFS
large files management (extenstion)
- Install it
- Initiate LFS
- Tag files to be added to lfs (.gitattributes) 
- Commit as usual the repo will store tagged files seperately

```sh
git lfs install
git lfs track "*.psd"
```
# Git GC (garbage collection)
git gc --aggressive
git gc --prune 