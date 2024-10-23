@isTest
public class AccountHandlerTestclass {
// Test method for updateAccountPhone
    @isTest
    static void testUpdateAccountPhone() {
        // Create a new test account
        Account testAcc = new Account(Name = 'Test Account', Phone = '1234567890');
        insert testAcc;
        
        // Update the phone number using the handler method
        AccountHandlerclass.updateAccountPhone(testAcc.Id, '0987654321');
        
        // Query the updated account
        Account updatedAcc = [SELECT Id, Phone FROM Account WHERE Id = :testAcc.Id];
        
        // Assert the phone number was updated
        System.assertEquals('0987654321', updatedAcc.Phone);
    }
    
    // Test method for getAccountName
    @isTest
    static void testGetAccountName() {
        // Create a new test account
        Account testAcc = new Account(Name = 'Test Account');
        insert testAcc;
        
        // Get the account name using the handler method
        String accName = AccountHandlerclass.getAccountName(testAcc.Id);
        
        // Assert the name is correct
        System.assertEquals('Test Account', accName);
    }
    
    // Test method for createNewAccount
    @isTest
    static void testCreateNewAccount() {
        // Create a new account using the handler method
        Account newAcc = AccountHandlerclass.createNewAccount('New Test Account');
        
        // Query the new account
        Account queriedAcc = [SELECT Id, Name FROM Account WHERE Id = :newAcc.Id];
        
        // Assert the account was created and the name is correct
        System.assertEquals('New Test Account', queriedAcc.Name);
    }
    
    // Utility method to provide test data
    @testSetup
    static void setupTestData() {
        // Create a test account
        Account testAcc = new Account(Name = 'Setup Test Account', Phone = '1122334455');
        insert testAcc;
    }
}