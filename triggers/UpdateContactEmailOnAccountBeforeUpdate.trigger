// Trigger on Account (before update)
trigger UpdateContactEmailOnAccountBeforeUpdate on Account (before update, after update, after insert) 
{
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            
        }
        when BEFORE_UPDATE {
            if(!CheckRecursion.run)
            {
                // Get all Contacts related to the Accounts being updated
                Map<Id, List<Contact>> accConMap = new Map<Id, List<Contact>>();
                for (Contact cnn : [SELECT Id, Email, AccountId, IsPrimary__c FROM Contact WHERE AccountId IN :Trigger.newMap.keySet()]) 
                {
                    if (!accConMap.containsKey(cnn.AccountId)) 
                    {
                        accConMap.put(cnn.AccountId, new List<Contact>());
                    }
                    accConMap.get(cnn.AccountId).add(cnn);
                }
                
                
                // List to hold contacts that need to be updated
                List<Contact> updateConList = new List<Contact>();
                
                // Iterate through each Account in the trigger
                for (Account acc : Trigger.new) 
                {
                    Boolean isPrimary = false;
                    String primaryEmail = '';
                    
                    if (accConMap.containsKey(acc.Id)) 
                    {
                        for (Contact con : accConMap.get(acc.Id)) 
                        {
                            if (con.IsPrimary__c) 
                            {
                                isPrimary = true;
                                primaryEmail = con.Email;
                                break;
                            }
                        }
                    }
                    
                    if (isPrimary && primaryEmail != null) 
                    {
                        acc.Email__c = primaryEmail;
                    } 
                    else 
                    {
                        if(acc.Email__c != null)
                        {
                            for (Contact con : accConMap.get(acc.Id)) 
                            {
                                if (con.Email != acc.Email__c) 
                                {
                                    con.Email = acc.Email__c;
                                    updateConList.add(con);
                                }
                            }
                        }
                    }
                    
                }
                
                // Update the contacts if there are any changes
                if (!updateConList.isEmpty()) 
                {
                    CheckRecursion.run = true;
                    update updateConList;
                }
            }
        }
        when BEFORE_DELETE {
            
        }
        when AFTER_INSERT {
            system.debug('After Insert Called');
            List<AccountChangeEvent__e> events = new List<AccountChangeEvent__e>();
            
            for (Account acc : Trigger.new) {
                AccountChangeEvent__e event = new AccountChangeEvent__e();
                event.AccountName__c = acc.Name;
                event.EventType__c = 'Insert';
                // Add other fields as needed
                events.add(event);
            }
            
            if (!events.isEmpty()) {
                EventBus.publish(events);
            }
        }
        when AFTER_UPDATE {
            system.debug('After Update Called');
            List<AccountChangeEvent__e> events = new List<AccountChangeEvent__e>();
            
            for (Account acc : Trigger.new) {
                AccountChangeEvent__e event = new AccountChangeEvent__e();
                event.AccountId__c = acc.Id;
                event.AccountName__c = acc.Name;
                event.EventType__c = 'Update';
                // Add other fields as needed
                events.add(event);
            }
            
            if (!events.isEmpty()) {
                system.debug('Events Value @@@@@@@ '+events);
                EventBus.publish(events);
            }
        }
        when AFTER_DELETE {
            
        }
    }
    
}