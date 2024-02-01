 #This script get endpoints from AKS dev and copy to hosts file like dns records
 kubectl config use-context glow-insurance-aks
 #get namespaces
 $namespace= kubectl get namespace
  
 #replace some trash
 $namespace= $namespace -replace " .+","" 
 $namespace= $namespace -replace "NAME","" 
 $namespace= $namespace -replace "kube-node-lease","" 
 $namespace= $namespace -replace "kube-public","" 
 $namespace= $namespace -replace "kube-system",""
 $namespace= $namespace -replace "insdemo",""
 $namespace = $namespace | select -uniq | where{$_ -ne ""}
 #$namespace= $namespace.split(" ")
 
 #clean hosts file
 "" > hosts
 #add a local names in hosts file
 "127.0.0.1 OpenVPNVM" >> hosts
 "127.0.0.1 localhost" >> hosts

 
 #loop namespaces
 foreach($name in $namespace){

 $hosts= kubectl get endpoints -n $name

 #replace some trash
 $hosts= $hosts -replace " +"," " 
 $hosts= $hosts -replace ":.+","" 
 #$hosts= $hosts -replace "84d","" 
 $hosts = $hosts[1.. $hosts.count]
 $hosts= $hosts.split(" ")

 #output in file
 $count = $hosts.Count
 for($i=0;$i -lt $count;$i++ ){
    $hosts[$i+1] + " " + $hosts[$i] + "." + $name + ".svc"   >> hosts
    $i++
     }

   }
 
 notepad hosts
 #copy to vm
 #scp azureuser@OpenVPNVM:./hosts /etc/hosts
 #restart service
 #ssh -t azureuser@OpenVPNVM sudo /bin/systemctl restart dnsmasq



