trigger CBDWorkItemPackageTrigger on CBD__Work_Item_Package__c (before insert, before update) {
    for (CBD__Work_Item_Package__c workItem : Trigger.new) {
        // Check if the Deployment Approver field is blank
        if (String.isBlank(workItem.CBD__Deployment_Approver__c)) {
            workItem.addError('Deployment Approver is required by trigger.');
        }
    }
}