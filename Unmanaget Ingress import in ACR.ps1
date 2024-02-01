$RegistryName = "glowcontainerregistry"
$ResourceGroup = "rg-build-services"
$SourceRegistry = "registry.k8s.io"
$ControllerImage = "ingress-nginx/controller"
$ControllerTag = "v1.8.1"
$PatchImage = "ingress-nginx/kube-webhook-certgen"
$PatchTag = "v20230407"
$DefaultBackendImage = "defaultbackend-amd64"
$DefaultBackendTag = "1.5"
$SubscriptionID = 'a4416f44-c24e-47f0-913e-dc9aa18ba914'

Import-AzContainerRegistryImage -ResourceGroupName $ResourceGroup -RegistryName $RegistryName -SourceRegistryUri $SourceRegistry -SourceImage "${ControllerImage}:${ControllerTag}" -SubscriptionId $SubscriptionID
Import-AzContainerRegistryImage -ResourceGroupName $ResourceGroup -RegistryName $RegistryName -SourceRegistryUri $SourceRegistry -SourceImage "${PatchImage}:${PatchTag}" -SubscriptionId $SubscriptionID
Import-AzContainerRegistryImage -ResourceGroupName $ResourceGroup -RegistryName $RegistryName -SourceRegistryUri $SourceRegistry -SourceImage "${DefaultBackendImage}:${DefaultBackendTag}" -SubscriptionId $SubscriptionID