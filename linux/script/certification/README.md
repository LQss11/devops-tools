# Managing certificates
You can follow these steps to generate the right certificates:
1. **server:** machine generate private key
2. **server:** generate a **ca self** signed certificate based on the generated private key 
3. **client:** machine generate private key
4. **client:** generate a certifcate requrest (csr) and share it to the **server**machine
5. **server:** approve the csr based on the server CA cert and the private key to generate a final key.