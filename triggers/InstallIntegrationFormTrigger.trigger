trigger InstallIntegrationFormTrigger on Install_Integration_Form__c (before insert) {
    
    switch on trigger.operationType
    {
        when BEFORE_INSERT
        {
            InstallIntegrationFormTriggerHandler.autoPopulate_FacilitySiteName_ContractID_BeforeInsert(trigger.new);
        }
    }

}