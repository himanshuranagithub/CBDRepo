@isTest
public class AccountCreationDemoTest {

    @isTest
    static void testCreateAccount() {
        // Start the test
        Test.startTest();

        // Call the method to be tested
        try {
            AccountCreationDemo.createAccount();

            // Verify the account was created
            Account createdAccount = [SELECT Id, Name, Industry FROM Account WHERE Name = 'Test Account' LIMIT 1];
            System.assertNotEquals(null, createdAccount, 'The account should have been created.');
            System.assertEquals('Test Account', createdAccount.Name, 'The account name should be "Test Account".');
            System.assertEquals('Technology', createdAccount.Industry, 'The account industry should be "Technology".');
        } catch (AuraHandledException e) {
            System.assert(false, 'There should be no exception when creating an account.');
        }

        // End the test
        Test.stopTest();
    }
}