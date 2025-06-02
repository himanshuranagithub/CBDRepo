@isTest
public class AccountTableTest {

    // Helper method to create test data
    private static List<Account> createTestAccounts(Integer numberOfAccounts) {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < numberOfAccounts; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i, Industry = 'Technology', Phone = '123456789', Website = 'www.test' + i + '.com'));
        }
        insert accounts;
        return accounts;
    }

    @isTest
    static void testGetAccountsWithoutSearchKey() {
        // Create test data
        List<Account> testAccounts = createTestAccounts(5);
        
        // Test getAccounts without a search key (should return the accounts ordered by Name)
        List<Account> result = AccountTable.getAccounts('');
      
        
        // Validate the result
        System.assertNotEquals(null, result);
        System.assertEquals(6, result.size());
    }

   
}