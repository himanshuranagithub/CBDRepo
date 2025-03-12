public class AccountDetailsFetcher {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountDetails() {
        List<Account> accountList = [SELECT Id, Name, Industry, AnnualRevenue FROM Account LIMIT 100];
        return accountList;
    }
}