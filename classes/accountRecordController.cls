public class accountRecordController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {      
        return [SELECT Id, Name, Email__c, Phone FROM Account LIMIT 10];
    }
}