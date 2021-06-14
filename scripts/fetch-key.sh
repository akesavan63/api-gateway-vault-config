#!/usr/bin/env sh

TENENT_ID=$1

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR/app
npm install

vaultPublicKeys=$(node fetchVaultPublicKeys.js "${TENENT_ID}")
#echo "$vaultPublicKeys"

echo "LOGIN"
vault login myroot &> /dev/null
echo "Creating Transit Engine"
vault secrets enable -version=2 -path=authorizer kv

cd $SCRIPT_DIR/app/keys
for FILE in *;
do
  echo $FILE;
  PUBLICKEYS=`cat $FILE`
  vault kv put authorizer/api-gateway/jwt/pub/active $FILE="$PUBLICKEYS"
done

cat <<EOF > /home/vault/privatekey.properties
-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEAn6VA2xt45CY0T9fPXxqofZccI5gRS+pe/uPz1ujjyWzbrKqa\nWE9+58FLnvLVq8HxYDnukbYuSK631SfDSfTd41TDRPVgQ9OvpVy9WOvcTvpltWEC\nnj8TR5HgztCUd5DSWWMlaEmcvDrioeB9jSEx49wA+aNw/JYhemes6BlEJcxrvX0Q\n0CIC41eexgs0TdH2nJNmvs0saNlKfGhtwlqNE93TTQZwVyrFPspfsSEBAc37sEil\nnfZN7CmmdH2qv2JBn9wc6H/kPF/5FGIykOwZH3B9wfF0SALATJeiPqBof5FZcgvD\nlQ1b2CSfNuIu9T+cyUvJCc+8eRTDUW/FDNfDswIDAQABAoIBACBFh5bDNuznzCtX\ntNPEz8qTgVywoM530jw0WFZZPbK6Dq4YzpqLd1vh9ydqb0cJLYIGM/PAoBqRNxgf\nsZqBpVkPCWonMA6F/DuxQ5V2GFLeyzCfK6hRl9Qf6RHlmB2TaPIo2Kb8OnLSdH3E\no5yj2TH2hzvvjieBMcNMsec5NE1vc5qV6sdp0ky3VjEmANw8mDVf4J0iscwSzfGi\nL3K5/rokqR7sQyEOb7V0U3xhO4O+h+0A9jJyXQczRSKtLmcJ7zIUOIGjvn3eBfFv\nHYCeiZIgHnOJPQdzH5wjUln7pWwrL+7g8PeRLhasjb1DOjaRmLzEC2tK37uuKF9R\nDOtUKgECgYEAx4WXwCIjc2XEf064EfMREXT/3zQItRDpufdHecIf+Niwh6GLSU8Y\n8mrn0/nsywezAInINwZ81PytvWLN/M1p4q3ODIXKo21ejpu/DINptIg7LLuO4S9U\n41alPNdECKoMrfkEvkSQFSzDaXKuSVB19CuqLgID4S/2/3Ul4tHkHcUCgYEAzNYC\n5ITI4oiE2DDnz3OJd1ur1r/h29mzsw/yji+o7YD8YdyJVcTylOqvqu3WYIwnH2kc\n0IkWPHX4lIxirFFYZ634N4m8q8DZxHPm4RxtK/+GAEI3lnvsLkn8oNFypY60W9G+\nrQi36SVMuAzXTuJlMGB5318sG3fXz/efmVWFKxcCgYAXFGgKbKiHJ8WEKHn4cZKO\n32bdzeoX793piiY1enQyV/aLqe8vyruLBzzL84QltD1LmaSUYOa9yIDcgHptfOF7\nvDkyj6NyJiui+XcvHmBy5rNZqFSNzejW52Xz1L7k9a7DzSN0UwALwwLTxtVMW8dZ\nOFfWPJtwSBkdUdLRGxB1NQKBgQCWhWGEyarRBN8R+wYtZMqMgjnJSiHPq6+okrx8\nDbvGI7XSt/vXoi1cjwTdx350XilVpKk++K31af9sMalE1VXwgl/XeAjD8ahU+5Ka\ns4fqABBZWk987r2E2muhRahIzo/stTm376Mt2XICAbWqSyVuokaMhWRlHvDg6ydF\nxxlfqwKBgQC/rOKHuKMi2BWAaiNk41fLJwa5wtDp+750s+Vm0JN8mz1iaRWUeep+\nk/k4Prr7YaAGNqP3nt3vDP/e10dj5NBLWV+cbEHrTPzHtQC/vRLnrcDrPUp0tdXP\ngSkB5dWfvnNfSHX+936y99Ot+ewVVJhPmtmnDmp3v1S9dSYAKHqBvA==\n-----END RSA PRIVATE KEY-----
EOF

vault kv put authorizer/api-gateway/jwt/priv/active ${TENENT_ID}=@/home/vault/privatekey.properties




