# Vault Approle example
In case of losing the root vault token the only way to retrieve it is through unseal keys, to do so you will have to run the following commands:
```sh
# Start the process (make sure to save the OTP key)
vault operator generate-root -init
# run this command and enter the unseal key each time until the progress is 3/3
vault operator generate-root
# Run this to check the status of the root key
vault operator generate-root -status
# Once you reach the last progress you will have an encoded token
# You can run this command to obtain the new root token
vault operator generate-root -decode < Encoded Token > -otp < OTP >
```

You can follow this [link](https://sleeplessbeastie.eu/2022/12/26/how-to-generate-new-vault-root-token/) as an example to generate the root key