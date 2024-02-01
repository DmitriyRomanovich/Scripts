
$ResourceGroup = "rg-build-services"
$SourceRegistry = "registry.k8s.io"
$ControllerImage = "ingress-nginx/controller"
$ControllerTag = "v1.8.1"
$PatchImage = "ingress-nginx/kube-webhook-certgen"
$PatchTag = "v20230407"
$DefaultBackendImage = "defaultbackend-amd64"
$DefaultBackendTag = "1.5"
$SubscriptionID = 'a4416f44-c24e-47f0-913e-dc9aa18ba914'

# Add the ingress-nginx repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Set variable for ACR location to use for pulling images
$AcrUrl = "registry.k8s.io"



#asigne permitions for action from AKS to VNET
az role assignment create --assignee 37c47e6d-5b54-4ad7-9ba2-c3894c0848c0 --role "Network Contributor" --scope /subscriptions/f5d8dd17-717d-4aca-9f60-f285e325e999/resourceGroups/rg-net-dev-uks/providers/Microsoft.Network/virtualNetworks/vnet-dev-uks/subnets/snet-aks-dev-uks


# Use Helm to deploy an NGINX ingress controller
helm install ingress-nginx ingress-nginx/ingress-nginx `
    --namespace ingress-basic `
    --create-namespace `
    --set controller.replicaCount=2 `
    --set controller.nodeSelector."kubernetes\.io/os"=linux `
    --set controller.image.registry=$AcrUrl `
    --set controller.image.image=$ControllerImage `
    --set controller.image.tag=$ControllerTag `
    --set controller.image.digest="" `
    --set controller.admissionWebhooks.patch.nodeSelector."kubernetes\.io/os"=linux `
    --set controller.service.loadBalancerIP=10.2.19.250 `
    --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-internal"=true `
    --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz `
    --set controller.admissionWebhooks.patch.image.registry=$AcrUrl `
    --set controller.admissionWebhooks.patch.image.image=$PatchImage `
    --set controller.admissionWebhooks.patch.image.tag=$PatchTag `
    --set controller.admissionWebhooks.patch.image.digest="" `
    --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux `
    --set defaultBackend.image.registry=$AcrUrl `
    --set defaultBackend.image.image=$DefaultBackendImage `
    --set defaultBackend.image.tag=$DefaultBackendTag `
    --set defaultBackend.image.digest="" 



#SERTS for AUTO ENV
Select-AzSubscription -SubscriptionName "glow-vmo2-subs"
$appgw = Get-AzApplicationGateway -Name appgw-dev-uks-agora
 -ResourceGroupName rg-app-gw-dev-uks-agora
$secret = Get-AzKeyVaultSecret -VaultName "kv-dev-uks-agora" -Name "wildcard-rsa-cert-agora-auto02"
$secretId = $secret.Id.Replace($secret.Version, "")
Add-AzApplicationGatewaySslCertificate -KeyVaultSecretId $secretId -ApplicationGateway $appgw -Name $secret.Name
Set-AzApplicationGateway -ApplicationGateway $appgw
#SERTS for QA ENV
Select-AzSubscription -SubscriptionName "glow-vmo2-subs"
$appgw = Get-AzApplicationGateway -Name appgw-dev-uks-agora
 -ResourceGroupName rg-app-gw-dev-uks-agora
$secret = Get-AzKeyVaultSecret -VaultName "kv-dev-uks-agora" -Name "wildcard-rsa-cert-agora-qa02"
$secretId = $secret.Id.Replace($secret.Version, "")
Add-AzApplicationGatewaySslCertificate -KeyVaultSecretId $secretId -ApplicationGateway $appgw -Name $secret.Name
Set-AzApplicationGateway -ApplicationGateway $appgw
#SERTS for DEV ENV
Select-AzSubscription -SubscriptionName "glow-vmo2-subs"
$appgw = Get-AzApplicationGateway -Name appgw-dev-uks-agora
 -ResourceGroupName rg-app-gw-dev-uks-agora
$secret = Get-AzKeyVaultSecret -VaultName "kv-dev-uks-agora" -Name "wildcard-rsa-cert-agora-dev02"
$secretId = $secret.Id.Replace($secret.Version, "")
Add-AzApplicationGatewaySslCertificate -KeyVaultSecretId $secretId -ApplicationGateway $appgw -Name $secret.Name
Set-AzApplicationGateway -ApplicationGateway $appgw

#mTLS
cd D:\sert
$client="glow"
$kv_name = "kv-dev-uks-agora"
$client = "glow"
$subscription="f5d8dd17-717d-4aca-9f60-f285e325e999"
$purpose="wmo2"

openssl req -x509 -nodes -new -sha512  -days 365 -newkey rsa:4096 -keyout ca-$client-$purpose.key -out ca-$client-$purpose.pem -subj "/C=UK/CN=$client"
openssl x509 -outform pem -in ca-$client-$purpose.pem -out ca-$client-$purpose.crt
openssl req -new -nodes -newkey rsa:4096 -keyout client-$client-$purpose.key -out client-$client-$purpose.csr -subj "/C=UK/ST=UK/L=City/O=$client/CN=loanrecommendation.prod.glowfinsvs.com"
openssl x509 -req -sha512 -days 365 -CA ca-$client-$purpose.crt -CAkey ca-$client-$purpose.key -CAcreateserial -in client-$client-$purpose.csr -out client-$client-$purpose.crt

#add to keyvault
az keyvault secret set --vault-name "kv-dev-uks-agora" --name "CERT-CA-glow-wmo2-PEM" --file "ca-glow-wmo2.pem" --subscription "f5d8dd17-717d-4aca-9f60-f285e325e999"
az keyvault secret set --vault-name "kv-dev-uks-agora" --name "CERT-CLIENT-glow-wmo2" --file "client-glow-wmo2.crt" --subscription "f5d8dd17-717d-4aca-9f60-f285e325e999"
az keyvault secret set --vault-name $kv_name --name "CERT-CLIENT-glow-wmo2-KEY" --file "client-glow-wmo2.key" --subscription "f5d8dd17-717d-4aca-9f60-f285e325e999"



