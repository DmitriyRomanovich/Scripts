# WARNING! This script deletes data!

#PARAMETERS
#########################################
$ENABLE_DELETE = "false"
$TIMESTAMP= "2021-05-06"
$REGISTRY= "glowacr02"
$REPOSITORY = "helm/calc"
#########################################

#get tags with create date
[System.Collections.ArrayList]$TAG = az acr repository show-tags -n $REGISTRY --repository $REPOSITORY 
$TAG.Remove("[")  
$TAG.Remove("]")  
$TIMESTAMP = $TIMESTAMP -replace "-","" 
$TAG2 = @($TAG)

#Leave images to delete
 foreach ($process in $TAG2){
    $TAG2 = $process  -replace ",","" 
    $TAG2 = $TAG2 -replace '"',"" 
    $TAG2 = $TAG2 -replace "\.\d","" 
    $TAG2 = $TAG2 -replace " +","" 
        if ($TAG2 -ge $TIMESTAMP){         
                $TAG.Remove($process)          
        }
    }
$TAG = $TAG  -replace ",","" 
$TAG = $TAG -replace '"',"" 
$TAG = $TAG  -replace " ","" 

#delete by TAG
Write-Host "WILL REMOVED:" $TAG.Count " IMAGES"
foreach ($process in $TAG){
    $image = $REPOSITORY +':' + $process
    Write-Host $image 
     if ($ENABLE_DELETE -eq "true"){ 
              az acr repository delete --name $REGISTRY --image  $image  --yes
              Write-Host "IMAGES " $image  "DELETED"
            }
    }
 
  