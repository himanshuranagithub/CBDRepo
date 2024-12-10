// Trigger on Contact (after insert, after update)
trigger UpdateAccountEmailOnPrimaryContactInsert on Contact (after insert, after update) 
{
    if(!CheckRecursion.run)
    {
        // Set to hold account ids that need to be updated
        Set<Id> accountIdsToUpdate = new Set<Id>();
        
        // Map to hold the primary email for each account
        Map<Id, String> accountPrimaryEmailMap = new Map<Id, String>();
        
        // Iterate through the inserted contacts
        for (Contact con : Trigger.new) 
        {
            if (con.IsPrimary__c && con.Email != null) 
            {
                accountIdsToUpdate.add(con.AccountId);
                accountPrimaryEmailMap.put(con.AccountId, con.Email);
            }
        }
        
        
        // List to hold accounts that need to be updated
        List<Account> accountsToUpdate = new List<Account>();
        
        if (!accountIdsToUpdate.isEmpty()) 
        {
            // Query the accounts that need to be updated
            for (Account acc : [SELECT Id, Email__c FROM Account WHERE Id IN :accountIdsToUpdate]) 
            {
                if (accountPrimaryEmailMap.containsKey(acc.Id)) 
                {
                    if (acc.Email__c != accountPrimaryEmailMap.get(acc.Id)) 
                    {
                        acc.Email__c = accountPrimaryEmailMap.get(acc.Id);
                        CheckRecursion.run = true;
                        accountsToUpdate.add(acc);
                    }
                }
            }
            
            // Update the accounts if there are any changes
            if (!accountsToUpdate.isEmpty()) 
            {
                update accountsToUpdate;
            }
        }
    }
}