public class OpportunityHandlerclass {
 // Method to update the close date of an Opportunity
    public static void updateOpportunityCloseDate(Id opportunityId, Date newCloseDate) {
        // Query the opportunity to be updated
        Opportunity opp = [SELECT Id, CloseDate FROM Opportunity WHERE Id = :opportunityId];
        opp.CloseDate = newCloseDate;
        update opp;
    }
    
    // Method to get Opportunity amount by Id
    public static Decimal getOpportunityAmount(Id opportunityId) {
        // Query the opportunity to get the amount
        Opportunity opp = [SELECT Id, Amount FROM Opportunity WHERE Id = :opportunityId];
        return opp.Amount;
    }
    
    // Method to create a new Opportunity
    public static Opportunity createNewOpportunity(String opportunityName, Id accountId) {
        Opportunity opp = new Opportunity(
            Name = opportunityName,
            AccountId = accountId,
            StageName = 'Prospecting',  // Default stage
            CloseDate = Date.today().addMonths(1) // Default close date
        );
        insert opp;
        return opp;
    }
}