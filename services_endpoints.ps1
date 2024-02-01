 #This script get endpoints from AKS dev and copy hosts file to VM

 #namespace with services
 $namespace = "insurtech"   

 $hosts= kubectl get endpoints -n $namespace
 #clean file
 "" > hosts

 #replace some trash
 $hosts= $hosts -replace " +"," " 
 $hosts= $hosts -replace ":.+",""  
 $hosts = $hosts[1.. $hosts.count]
 $hosts= $hosts.split(" ")

 #output in file
 $count = $hosts.Count
 for($i=0;$i -lt $count;$i++ ){
    $hosts[$i+1] + " " + $hosts[$i] + "." + $namespace + ".svc"   >> hosts
    $i++
 }
 
 #add a local names
 "127.0.0.1 OpenVPNVM" >> hosts
 "127.0.0.1 localhost" >> hosts
 
 notepad hosts
 #copy to vm
 #scp azureuser@OpenVPNVM:./hosts /etc/hosts
 #restart service
 #ssh -t azureuser@OpenVPNVM sudo /bin/systemctl restart dnsmasq
 
 