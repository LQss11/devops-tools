# Markdown to Pdf
One of the most used convertors are `pandoc` you can follow this [link](https://pandoc.org/installing.html) to know more about it and install it
## Linux commands
```sh
docker run -it --rm  -v ${pwd}:/app -w /app pandoc/latex README.md -o README.pdf
docker run -it --rm  -v ${pwd}:/app -w /app pandoc/extra README.md -o README2.pdf --template eisvogel --listings
docker run -it --rm -v ${pwd}:/app -w /app pandoc/extra README.md -o README2.pdf --template eisvogel --listings --metadata-file=metadata.yaml --pdf-engine=xelatex 





code version use stable --install-dir $(which code)
```