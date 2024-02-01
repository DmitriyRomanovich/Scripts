$env:RabbitUser = "agent"
$env:RabbitPassword = "agent"
$RabbitNamespace = "shared"
$env:RabbitVHost = "stg"
$env:RabbitIP = kubectl get endpoints rabbitmq -n $RabbitNamespace -o jsonpath='{..ip}'
 
 
kubectl exec -it rabbitmq-0 -n $RabbitNamespace  -- rabbitmqctl add_vhost $env:RabbitVHost
kubectl exec -it rabbitmq-0 -n $RabbitNamespace  -- rabbitmqctl set_permissions -p $env:RabbitVHost $env:RabbitUser ".*" ".*" ".*"
 
### GLOW
 
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=CustomerRecordNotification type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CustomerRecordNotification durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=CustomerRecordNotification destination_type=queue destination=CustomerRecordNotification -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=DocumentAgentReview type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=ProposalCreate type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=ProposalApply type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=ProposalRevoke type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=ServicesEnable type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=ServicesEnabled type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=ServicesRequestInfo type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=ServicesRequestedInfo type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=AdyenNotificationProceed type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=CartUpdateOnline type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=AdyenReportNotificationProceed type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=LoanAgreementChange type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=LocalizationVersionChanged type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=SignalR type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=ServicesDisabled type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=ServicesDisable type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=ClientSignalR type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=AccertifyTransactionResolutionResponse type=direct -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=LoanOutcomeResend type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=ServicesDashboardSignalR type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=UserConnected type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=UserDisconnected type=direct -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=DocumentAgentReview durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=ProposalCreate durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=ProposalApply durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=ProposalRevoke durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=AdyenNotificationProceed durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CartUpdateOnline durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=AdyenReportNotificationProceed durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=LoanAgreementChange durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=AccertifyTransactionResolutionResponse durable=true -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=LoanOutcomeResend durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=UserConnected durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=UserDisconnected durable=true -u $env:RabbitUser -p $env:RabbitPassword
 
 
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=DocumentAgentReview destination_type=queue destination=DocumentAgentReview --u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=ProposalCreate destination_type=queue destination=ProposalCreate -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=ProposalApply destination_type=queue destination=ProposalApply -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=ProposalRevoke destination_type=queue destination=ProposalRevoke -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=AdyenNotificationProceed destination_type=queue destination=AdyenNotificationProceed -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=CartUpdateOnline destination_type=queue destination=CartUpdateOnline -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=AdyenReportNotificationProceed destination_type=queue destination=AdyenReportNotificationProceed -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=LoanAgreementChange destination_type=queue destination=LoanAgreementChange -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=AccertifyTransactionResolutionResponse destination_type=queue destination=AccertifyTransactionResolutionResponse -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=LoanOutcomeResend destination_type=queue destination=LoanOutcomeResend -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=UserConnected destination_type=queue destination=UserConnected -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=UserDisconnected destination_type=queue destination=UserDisconnected -u $env:RabbitUser -p $env:RabbitPassword
 
 
## EE part for GLOW
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare exchange name=CartUpdateEe type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare queue name=CartUpdateEe durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=CartUpdateEe destination_type=queue destination=CartUpdateEe -u $env:RabbitUser -p $env:RabbitPassword
 
 
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare exchange name=EeProposalCreateViaRuleEngine type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare queue name=EeProposalCreateViaRuleEngine durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=EeProposalCreateViaRuleEngine destination_type=queue destination=EeProposalCreateViaRuleEngine -u $env:RabbitUser -p $env:RabbitPassword
 
## RE part for GLOW
 
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=ProposalCreateViaRuleEngine type=direct -u $env:RabbitUser -p $env:RabbitPassword	
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=ProposalCreateViaRuleEngine durable=true -u $env:RabbitUser -p $env:RabbitPassword	
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=ProposalCreateViaRuleEngine destination_type=queue destination=ProposalCreateViaRuleEngine -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=HandleRuleEngineResult type=direct -u $env:RabbitUser -p $env:RabbitPassword	
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=HandleRuleEngineResult durable=true -u $env:RabbitUser -p $env:RabbitPassword	
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=HandleRuleEngineResult destination_type=queue destination=HandleRuleEngineResult -u $env:RabbitUser -p $env:RabbitPassword
 
 
 
_______________________________________________
### RULESENGINE
 
$env:RabbitUser = "agent"
$env:RabbitPassword = "agent"
$RabbitNamespace = "shared"
$env:RabbitVHost = "uat-eng"
$ConsumerOrigin = "Glow_Fin_UAT"
$ConsumerQueueName =  [string]::Format("ReWorker_{0}_Result_Queue", $ConsumerOrigin) 	# ReWorker_Glow_Fin_INT_Result_Queue
$ConsumerRoutingKey = [string]::Format("{0}_Result", $ConsumerOrigin)					# Glow_Fin_INT_Result
$env:RabbitIP = kubectl get endpoints rabbitmq -n $RabbitNamespace -o jsonpath='{..ip}'
 
kubectl exec -it rabbitmq-0 -n $RabbitNamespace  -- rabbitmqctl add_vhost $env:RabbitVHost
kubectl exec -it rabbitmq-0 -n $RabbitNamespace  -- rabbitmqctl set_permissions -p $env:RabbitVHost $env:RabbitUser ".*" ".*" ".*"
 
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=ReWorkerIncomingExchange type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=ReWorkerOutgoingExchange type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=ReWorkerInvalidateCacheExchange type=fanout -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=ReWorkerStartExecutionQueue durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=ReWorkerContinueExecutionQueue durable=true -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP declare binding --vhost=$env:RabbitVHost source=ReWorkerIncomingExchange destination_type=queue destination=ReWorkerStartExecutionQueue routing_key=StartExecution -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare binding --vhost=$env:RabbitVHost source=ReWorkerIncomingExchange destination_type=queue destination=ReWorkerContinueExecutionQueue routing_key=ContinueExecution -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=$ConsumerQueueName durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare binding --vhost=$env:RabbitVHost source=ReWorkerOutgoingExchange destination_type=queue destination=$ConsumerQueueName routing_key=$ConsumerRoutingKey -u $env:RabbitUser -p $env:RabbitPassword
 
 
 
 
 
COMMS
$env:RabbitUser = "agent"     
$env:RabbitPassword = "agent"
$env:RabbitVHost = "comms-stg"
$RabbitNamespace = "glowcommon"
$env:RabbitIP = kubectl get endpoints rabbitmq -n $RabbitNamespace -o jsonpath='{..ip}'   
 
kubectl exec -it rabbitmq-0 -n $RabbitNamespace  -- rabbitmqctl add_vhost $env:RabbitVHost
kubectl exec -it rabbitmq-0 -n $RabbitNamespace  -- rabbitmqctl set_permissions -p $env:RabbitVHost $env:RabbitUser ".*" ".*" ".*"
 
 
$CommsGatewayOrigin = "CommsGateway"
$CommsIntegrationPortalOrigin = "CommsIntegrationPortal"
 
 
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=CommsNotificationIncomingExchange type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=CommsNotificationOutgoingExchange type=direct -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=CommsRenderingIncomingExchange type=fanout -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=CommsRenderingOutgoingExchange type=direct -u $env:RabbitUser -p $env:RabbitPassword
 
 
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CommsNotificationIncomingSmsQueue durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CommsNotificationIncomingEmailQueue durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CommsNotificationIncomingWhatsAppQueue durable=true -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CommsRenderingIncomingQueue durable=true -u $env:RabbitUser -p $env:RabbitPassword
 
 
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CommsGatewayNotificationOutgoingQueue durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CommsGatewayRenderingOutgoingQueue durable=true -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CommsIntegrationPortalNotificationOutgoingQueue durable=true -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP declare binding --vhost=$env:RabbitVHost source=CommsNotificationIncomingExchange destination_type=queue destination=CommsNotificationIncomingSmsQueue routing_key=Sms -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare binding --vhost=$env:RabbitVHost source=CommsNotificationIncomingExchange destination_type=queue destination=CommsNotificationIncomingEmailQueue routing_key=Email -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare binding --vhost=$env:RabbitVHost source=CommsNotificationIncomingExchange destination_type=queue destination=CommsNotificationIncomingWhatsAppQueue routing_key=WhatsApp -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP declare binding --vhost=$env:RabbitVHost source=CommsRenderingIncomingExchange destination_type=queue destination=CommsRenderingIncomingQueue -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP declare binding --vhost=$env:RabbitVHost source=CommsNotificationOutgoingExchange destination_type=queue destination=CommsGatewayNotificationOutgoingQueue routing_key=$CommsGatewayOrigin -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare binding --vhost=$env:RabbitVHost source=CommsRenderingOutgoingExchange destination_type=queue destination=CommsGatewayRenderingOutgoingQueue routing_key=$CommsGatewayOrigin -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP declare binding --vhost=$env:RabbitVHost source=CommsNotificationOutgoingExchange destination_type=queue destination=CommsIntegrationPortalNotificationOutgoingQueue routing_key=$CommsIntegrationPortalOrigin -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=CommsProcessingIncomingExchange type=fanout -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CommsProcessingIncomingQueue durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare binding --vhost=$env:RabbitVHost source=CommsProcessingIncomingExchange destination_type=queue destination=CommsProcessingIncomingQueue -u $env:RabbitUser -p $env:RabbitPassword
 
 
Customer portal
 
$env:RabbitUser = "agent"
$env:RabbitPassword = "agent"
$RabbitNamespace = "shared"
$env:RabbitVHost = "int"
$env:RabbitIP = kubectl get endpoints rabbitmq -n $RabbitNamespace -o jsonpath='{..ip}'
 
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=SendTemplatedEmail type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=SendEmail type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=SendTemplatedEmail  durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=SendEmail durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=SendTemplatedEmail destination_type=queue destination=SendTemplatedEmail --u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=SendEmail destination_type=queue destination=SendEmail --u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=SMSSender.Send  durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=NotificationSender.Send  durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CustomerCreated  durable=true -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP -V $env:RabbitVHost -u $env:RabbitUser -p $env:RabbitPassword list exchanges
python.exe rabbitmqadmin -H $env:RabbitIP -V $env:RabbitVHost -u $env:RabbitUser -p $env:RabbitPassword list queues
python.exe rabbitmqadmin -H $env:RabbitIP -V $env:RabbitVHost -u $env:RabbitUser -p $env:RabbitPassword list bindings
 
 
### SMSNG/AEU/DEV/CP
 
$env:RabbitUser = "agent"
$env:RabbitPassword = "agent"
$RabbitNamespace = "shared"
$env:RabbitVHost = "dev"
$env:RabbitIP = kubectl get endpoints rabbitmq -n $RabbitNamespace -o jsonpath='{..ip}' 
kubectl exec -it rabbitmq-0 -n $RabbitNamespace  -- rabbitmqctl add_vhost $env:RabbitVHost
kubectl exec -it rabbitmq-0 -n $RabbitNamespace  -- rabbitmqctl set_permissions -p $env:RabbitVHost $env:RabbitUser ".*" ".*" ".*"
 
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=CR_CustomerEventRequest type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=CR_CustomerEventResult type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=CR_CustomerEventServiceHandleRequest type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=CR_CustomerEventServiceHandleResult type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=CR_LoanEvent type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=CR_PaymentsEvent type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=CR_NetSuiteEvent type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=CR_AryzaEvent type=direct -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare exchange --vhost=$env:RabbitVHost name=CR_CustomerEventActionResult type=direct -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CR_CustomerEventRequest durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CR_CustomerEventResult durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CR_CustomerEventServiceHandleRequest durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CR_CustomerEventServiceHandleResult durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CR_LoanEvent durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CR_PaymentsEvent durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CR_NetSuiteEvent durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CR_AryzaEvent durable=true -u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP declare queue --vhost=$env:RabbitVHost name=CR_CustomerEventActionResult durable=true -u $env:RabbitUser -p $env:RabbitPassword
 
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=CR_CustomerEventRequest destination_type=queue destination=CR_CustomerEventRequest --u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=CR_CustomerEventResult destination_type=queue destination=CR_CustomerEventResult --u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=CR_CustomerEventServiceHandleRequest destination_type=queue destination=CR_CustomerEventServiceHandleRequest --u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=CR_CustomerEventServiceHandleResult destination_type=queue destination=CR_CustomerEventServiceHandleResult --u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=CR_LoanEvent destination_type=queue destination=CR_LoanEvent --u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=CR_PaymentsEvent destination_type=queue destination=CR_PaymentsEvent --u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=CR_NetSuiteEvent destination_type=queue destination=CR_NetSuiteEvent --u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=CR_AryzaEvent destination_type=queue destination=CR_AryzaEvent --u $env:RabbitUser -p $env:RabbitPassword
python.exe rabbitmqadmin -H $env:RabbitIP --vhost=$env:RabbitVHost declare binding source=CR_CustomerEventActionResult destination_type=queue destination=CR_CustomerEventActionResult --u $env:RabbitUser -p $env:RabbitPassword