git config --global user.email "myuser"
git config --global user.name "example@email.com"
cat .git.config
# Normalize and disable line ending conversion.
git config --global core.eol lf
git config --global core.autocrlf false
