/*

@Class Name               InstallIntegrationFormTriggerHandler
@Author                   Surya
@Date                     17/06/2022
@Description              To auto-populate Facility Site and Contract ID field values with the help of Contact look-up field in the Install Integration Form Object

*/


public class InstallIntegrationFormTriggerHandler {
    
    public static void autoPopulate_FacilitySiteName_ContractID_BeforeInsert(list<Install_Integration_Form__c> insFormList)
    {
        try{
            set<Id> contactIdSet = new set<Id>();
            set<Id> accountIdSet = new set<Id>();
            
            //Getting Contact Ids from Install Integration Form and adding it to a set(contactIdSet)
            
            for(Install_Integration_Form__c ins : insFormList)
            {
                if(ins.Contact__c != Null)
                {
                    contactIdSet.add(ins.Contact__c);
                }
            }
            system.debug('contactIdSet'+contactIdSet);
            
            
            // Getting Contacts with Account -> Using ContactIdSet
            
            list<contact> contactAccountList = [SELECT Id, Name, AccountId FROM Contact WHERE AccountId != Null AND Id IN :contactIdSet];
            
            
            // Getting AccountId's from Contacts -> Using contactAccountList and adding it to a set(accountIdSet)
            
            for(contact contAccount : contactAccountList)
            {
                if(contAccount.AccountId != Null)
                {
                    accountIdSet.add(contAccount.AccountId); 
                }
            }
            
            system.debug('accountIdSet'+accountIdSet);
            
            
            // Getting Accounts with Contracts -> Using accountIdset and storing it in a Map
            // Querying Facility Site to get Older record
            
            Map<Id, account> accountContractMap = new Map<Id, account>([SELECT Id, Name, (SELECT Id, Contract_Type__c FROM Contracts WHERE Contract_Type__c = 'SECURUS' ORDER BY CreatedDate ASC LIMIT 1) FROM Account WHERE ID IN :accountIdSet]);
            Facility_Site__c facility = [SELECT Id, Name FROM Facility_Site__c ORDER BY CreatedDate ASC LIMIT 1];
            
            system.debug('accountContractMap'+accountContractMap);
            system.debug('facility'+facility);
            
            // Looping through IIF object and checking the condition to auto-populate the field values
            
            for(Install_Integration_Form__c insForm : insFormList)
            {
                insForm.Facility_Site__c = facility.Id;									// assigning value from facility object
                
                if(insForm.Contact__c != NULL)
                {
                    for(contact cont : contactAccountList)
                    {
                        if(cont.AccountId != Null && accountContractMap.containsKey(cont.AccountId))	// checking AccountId of Contact matches with Account
                        {
                            Contract con = accountContractMap.get(cont.AccountId).Contracts;			// Assigning value to Contract from accountContractMap
                            
                            system.debug('Account Map '+accountContractMap.get(cont.AccountId));			
                            system.debug('Contract Record '+con);
                            
                            if(con.id != null){															// checking Contract Record is not null
                                insForm.Contract_Id__c = con.Id;										// assigning value from Contract object
                            }
                            
                        }
                    }
                }
            }
        }
        catch(exception e)
        {
            system.debug('Error Message is '+e.getMessage());
        }
    }
    
}