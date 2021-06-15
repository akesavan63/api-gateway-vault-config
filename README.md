# API Gateway Vault Configuration
The project is to run the vault locally for development.

## Prerequisite 
Install docker and docker-compose on your machine.

---

## Environment Variables
  Set the mandatory environment variable. 

  ```sh
  ISSUER_URL=<ISSUER URL>
  # e.g ISSUER_URL=https://sts.windows.net/<TENANT_ID>/
  
  REQUIRE_SERVICE_EXECUTE=Service.Access.Execute
  
  VAULT_SECRET_PATH_PUBLIC=<PUBLIC KEY PATH> 
  # e.g VAULT_SECRET_PATH_PUBLIC=authorizer/data/api-gateway/jwt/pub/active
  # NOTE: The full path is constructed as follows <SECRET_ENGINE>/data/<PUBLIC_SECRET_PATH>
  
  VAULT_SECRET_PATH_PRIVATE=<PRIVATE KEY PATH>
  # e.g VAULT_SECRET_PATH_PRIVATE=authorizer/data/api-gateway/jwt/priv/active
  # NOTE: The full path is constructed as follows <SECRET_ENGINE>/data/<PRIVATE_SECRET_PATH>
  
  # On docker deployment, you need to set the token manually, only for dev testing.
  VAULT_AUTH_TOKEN=<TOKEN> 
  # VAULT_AUTH_TOKEN=myroot
 
  ```

---

## Run the Vault Docker

  The helper script is available to run it on the window terminals
```sh
  
  # To start the docker instance.
  startup.bat
  
  # To stop the docker instance.
  remove.bat
  
  # if you want to re-instantiate the docker instance
  reset.bat
  
  # CLI to the docker instance.
  cli.bat
 
  ```

