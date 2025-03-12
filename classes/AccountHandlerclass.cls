public class AccountHandlerclass {
// Method to update the phone number of an Account new
    public static void updateAccountPhone(Id accountId, String newPhone) {
        // Query the account to be updated new
        Account acc = [SELECT Id, Phone FROM Account WHERE Id = :accountId];
        acc.Phone = newPhone;
        update acc;
    }
    
    // Method to get Account name by Id new
    public static String getAccountName(Id accountId) {
        // Query the account to get the name new
        Account acc = [SELECT Id, Name FROM Account WHERE Id = :accountId];
        return acc.Name;
    }
    
    // Method to create a new Account new
    public static Account createNewAccount(String accountName) {
        Account acc = new Account(Name = accountName);
        insert acc;
        return acc;
    } 
}