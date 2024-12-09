@isTest
public class OpportunityHandlerTestclass {
// Test method for updateOpportunityCloseDate
    @isTest
    static void testUpdateOpportunityCloseDate() {
        // Create a new test account
        Account testAcc = new Account(Name = 'Test Account');
        insert testAcc;
        
        // Create a new test opportunity
        Opportunity testOpp = new Opportunity(
            Name = 'Test Opportunity',
            AccountId = testAcc.Id,
            StageName = 'Prospecting',
            CloseDate = Date.today().addMonths(1)
        );
        insert testOpp;
        
        // Update the close date using the handler method
        OpportunityHandlerclass.updateOpportunityCloseDate(testOpp.Id, Date.today().addMonths(2));
        
        // Query the updated opportunity
        Opportunity updatedOpp = [SELECT Id, CloseDate FROM Opportunity WHERE Id = :testOpp.Id];
        
        // Assert the close date was updated
        System.assertEquals(Date.today().addMonths(2), updatedOpp.CloseDate);
    }
    
    // Test method for getOpportunityAmount
    @isTest
    static void testGetOpportunityAmount() {
        // Create a new test account
        Account testAcc = new Account(Name = 'Test Account');
        insert testAcc;
        
        // Create a new test opportunity
        Opportunity testOpp = new Opportunity(
            Name = 'Test Opportunity',
            AccountId = testAcc.Id,
            StageName = 'Prospecting',
            CloseDate = Date.today().addMonths(1),
            Amount = 1000
        );
        insert testOpp;
        
        // Get the opportunity amount using the handler method
        Decimal oppAmount = OpportunityHandlerclass.getOpportunityAmount(testOpp.Id);
        
        // Assert the amount is correct
        System.assertEquals(1000, oppAmount);
    }
    
    // Test method for createNewOpportunity
    @isTest
    static void testCreateNewOpportunity() {
        // Create a new test account
        Account testAcc = new Account(Name = 'Test Account');
        insert testAcc;
        
        // Create a new opportunity using the handler method
        Opportunity newOpp = OpportunityHandlerclass.createNewOpportunity('New Test Opportunity', testAcc.Id);
        
        // Query the new opportunity
        Opportunity queriedOpp = [SELECT Id, Name, AccountId FROM Opportunity WHERE Id = :newOpp.Id];
        
        // Assert the opportunity was created and the name is correct
        System.assertEquals('New Test Opportunity', queriedOpp.Name);
        System.assertEquals(testAcc.Id, queriedOpp.AccountId);
    }
    
    // Utility method to provide test data
    @testSetup
    static void setupTestData() {
        // Create a test account
        Account testAcc = new Account(Name = 'Setup Test Account');
        insert testAcc;
        
        // Create a test opportunity
        Opportunity testOpp = new Opportunity(
            Name = 'Setup Test Opportunity',
            AccountId = testAcc.Id,
            StageName = 'Prospecting',
            CloseDate = Date.today().addMonths(1)
        );
        insert testOpp;
    }
}