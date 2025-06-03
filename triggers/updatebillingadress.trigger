trigger updatebillingadress on Account (before update) {
    for(Account acc : Trigger.new){
        if(acc.Billing_city__c=='Hapur'){
            acc.Billing_city__c='Delhi';
        }
    }

}