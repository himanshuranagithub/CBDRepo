trigger CBDDeploymentTrigger on CBD__Deployment__c (before update) {
    for (CBD__Deployment__c deployment : Trigger.new) {
        // Check if the current value of CBD__Status__c  is not "Success"
        if (deployment.CBD__Status__c!= 'Success') {
            deployment.CBD__Status__c= 'Success';
        }
    }
}