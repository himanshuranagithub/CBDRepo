public class accountDataFatch {
    public static List<Account> fetchAndAddAccountInList() {
        List<Account> accList = [SELECT Id, Name FROM Account LIMIT 10];
        system.debug('accList@@@'+accList);
        List<Account> newAccountList = new List<Account>();
        
        for (Account acc : accList) {
            newAccountList.add(acc);
            system.debug('newAccountList@@@'+newAccountList);
        }
        
        return newAccountList;
    }
    public static Map<Id, Account> fetchAndAddAccountInMap() {
        List<Account> accList = [SELECT Id, Name FROM Account LIMIT 10];
        Map<Id, Account> accountMap = new Map<Id, Account>(accList);
        system.debug('accountMap@@@'+accountMap);
        Map<Id, Account> accMap = new Map<Id, Account>();
        
        for (Id accountId : accountMap.keySet()) {
            Account acc = accountMap.get(accountId);
            system.debug('acc@@@'+acc);
            accMap.put(accountId, acc);
            system.debug('accMap@@@'+accMap);
            Account getAccountRecord = accMap.get(AccountId);
            System.debug('Account Name is' + getAccountRecord.Name);
        }
        
        return accMap;
    }

}