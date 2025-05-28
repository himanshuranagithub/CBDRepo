public class AccountLwc {
    @auraenabled(cacheable = true)
    public static List<Account> getAccount(){
        return[SELECT Id,Name,phone,Fax,Type From Account];
    }
    @auraenabled(cacheable = false)
    public static void deleteAccount(string AccountId, string AccountIds){
        system.debug('accid ' + AccountId + ' AccountIds ' + AccountIds);
        
        if(AccountId != null){
            Account acc = [SELECT Id from Account Where Id = : AccountId limit 1];
            delete acc;
        }
       if(Accountids != null){
            List<Id> listOfIdStrings = AccountIds.split(',');
           List<Account> lstAccount = [SELECT Id from Account Where Id =: listOfIdStrings];
           delete lstAccount;
        }
    }

}