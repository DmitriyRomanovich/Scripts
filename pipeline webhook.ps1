$AzureDevOpsPAT = "6ict5sgn6a73bxuqt2klu4e5wmpx2vli4yg5smce4hcleqpaudkq"
 
$AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }

$uriAccount = "https://dev.azure.com/glowfs/Samsung/_apis/pipelines/191/runs?api-version=7.0"
 
    $body = "
    { 
        definition: { 
            id: $($buildDef.id) 
        }, 
        reason: 'Manual', 
        priority: 'Normal',
        parameters: ""{
            'system.debug':'true'
        }""
    }" # build body

#$json = $body | ConvertTo-Json

$output = Invoke-RestMethod -Uri $uriAccount -Method Patch -Headers $AzureDevOpsAuthenicationHeader -Body $json -ContentType application/json

$output