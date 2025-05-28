trigger AccountAddressMatch on Account (before insert,before update) {
    for(Account acc : Trigger.new){
        if(acc.billingpostelcode__c !=null & acc.shippingpostelcode__c != null){
             if (acc.billingpostelcode__c != acc.shippingpostelcode__c) {
                acc.addError('Billing Postal Code must match Shipping Postal Code.');
            }
        }
    }
}