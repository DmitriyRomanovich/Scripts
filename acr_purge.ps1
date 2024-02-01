
# WARNING! This script deletes data!
# Run only if you do not have systems
# that pull images via manifest digest.

# Change to 'true' to enable image delete
$ENABLE_DELETE = "false"
# Modify for your environment
# TIMESTAMP can be a date-time string such as 2019-03-15T17:55:0
$REGISTRY= "glowacr02"
$TIMESTAMP= "2021-05-06"  

#get list repo
$REPOSITORY = az acr repository list -n glowacr02
#cleen trash
$REPOSITORY = $REPOSITORY -replace ",","" 
$REPOSITORY = $REPOSITORY -replace '"',"" 
$REPOSITORY = $REPOSITORY -replace " +","" 

# Delete all images older than specified timestamp.
if ( $ENABLE_DELETE = "true" ){
     $count = $REPOSITORY.Count
 for($i=0;$i -lt $count;$i++ ){ 
        Write-Host "REPOSITORY:"$REPOSITORY[12]
        az acr repository show-manifests --name $REGISTRY --repository $REPOSITORY[12] --orderby time_asc --query "[?timestamp < '$TIMESTAMP'].digest" -o tsv 
     #| ForEach-Object az acr repository delete --name $REGISTRY --image $REPOSITORY[$i]:$_ --yes


        }
     }
else{
    echo "No data deleted."
    echo "Set ENABLE_DELETE=true to enable deletion of these images in $($REPOSITORY):"
    $count = $REPOSITORY.Count
    for($i=0;$i -lt $count;$i++ ){
        az acr repository show-manifests --name $REGISTRY --repository $REPOSITORY[$i] --orderby time_asc --query "[?timestamp < '$TIMESTAMP'].[digest, timestamp]" -o tsv
        }
   }