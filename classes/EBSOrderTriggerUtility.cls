/*
*	Author : Kumar Saurav
* 	Created : 12-15-2023 
*	Updated : 12-26-2024
*	JIRA Ticket: SF-1235,MP-313, SF-1946
*	Description : This Apex Class is used to create and populate contacts on PO,Shipping,Order,Sales emails.
*/

public without sharing class EBSOrderTriggerUtility { 
    public static boolean isUpdated = false; 
    private static String recordTypeID = KoozieUtility.getRecordTypeId('Contact', 'CRM Contact');
    private static List<Contact> newContactList = new List<Contact>();
    private static List<Contact> successfullyInsertedContactList = new List<Contact>();
    private static List<EBS_Order__c> updateEBSOrderList = new List<EBS_Order__c>();
    private static Set<Id> updateEBSOrdersRecordIds = new Set<Id>();
    private static Map<String, String> newContactMap = new Map<String, String>();
    private static String domain = '@kooziegroup.com';
    private static Id koozieGroupAccountId = System.Label.Koozie_Group_Account_Id;
    /*
*	Description : popoulate new Contact list based on the scenarios
*/
 public static void populateContactsOnOrder(List<EBS_Order__c> newEBSOrderList, Map<Id, EBS_Order__c> oldEBSOrderMap) {
    if (!isUpdated) {
        System.debug('Helper called@@@@@@');
        try {
            List<EBS_Order__c> ebsRecordsToProcess = [
                SELECT Id, Account_Name__c, Account_Name__r.Customer_Class_Code__c, 
                Distributor_Account__c, Sales_Contact__c, PO_Contact__c, Order_Confirm_Contact__c, 
                Shipping_Notif_Contact__c, SalesContact__c, PO_Contact_Email__c, 
                Order_Confirmation_Email__c, Shipping_Notification_Email__c, 
                Sales_Contact_First_Name__c, Sales_Contact_Last_Name__c
                FROM EBS_Order__c 
                WHERE Id IN :newEBSOrderList
            ];
            
            for (EBS_Order__c ebsRecord : ebsRecordsToProcess) {
                // PO Contact Logic (Unchanged)
                if (ebsRecord.PO_Contact_Email__c != null) {
                    List<Contact> existingContacts = [
                        SELECT Id, Email, AccountId
                        FROM Contact
                        WHERE Email = :ebsRecord.PO_Contact_Email__c
                        LIMIT 1
                    ];
                    
                    if (!existingContacts.isEmpty()) {
                        ebsRecord.PO_Contact__c = existingContacts[0].Id;
                    } else {
                        newContactList.add(new Contact(
                            FirstName = 'Valued',
                            LastName = 'Customer',
                            AccountId = ebsRecord.Account_Name__c != null
                                ? ebsRecord.Account_Name__c
                                : koozieGroupAccountId,
                            Email = ebsRecord.PO_Contact_Email__c,
                            RecordTypeId = recordTypeID
                        ));
                        updateEBSOrdersRecordIds.add(ebsRecord.Id);
                    }
                }

                // Order Confirmation Contact Logic (Unchanged)
                if (ebsRecord.Order_Confirmation_Email__c != null) {
                    List<Contact> existingContacts = [
                        SELECT Id, Email, AccountId
                        FROM Contact
                        WHERE Email = :ebsRecord.Order_Confirmation_Email__c
                        LIMIT 1
                    ];
                    
                    if (!existingContacts.isEmpty()) {
                        ebsRecord.Order_Confirm_Contact__c = existingContacts[0].Id;
                    } else {
                        newContactList.add(new Contact(
                            FirstName = 'Valued',
                            LastName = 'Customer',
                            AccountId = ebsRecord.Account_Name__c != null
                                ? ebsRecord.Account_Name__c
                                : koozieGroupAccountId,
                            Email = ebsRecord.Order_Confirmation_Email__c,
                            RecordTypeId = recordTypeID
                        ));
                        updateEBSOrdersRecordIds.add(ebsRecord.Id);
                    }
                }

                // Shipping Notification Contact Logic (Unchanged)
                if (ebsRecord.Shipping_Notification_Email__c != null) {
                    List<Contact> existingContacts = [
                        SELECT Id, Email, AccountId
                        FROM Contact
                        WHERE Email = :ebsRecord.Shipping_Notification_Email__c
                        LIMIT 1
                    ];
                    
                    if (!existingContacts.isEmpty()) {
                        ebsRecord.Shipping_Notif_Contact__c = existingContacts[0].Id;
                    } else {
                        newContactList.add(new Contact(
                            FirstName = 'Valued',
                            LastName = 'Customer',
                            AccountId = ebsRecord.Account_Name__c != null
                                ? ebsRecord.Account_Name__c
                                : koozieGroupAccountId,
                            Email = ebsRecord.Shipping_Notification_Email__c,
                            RecordTypeId = recordTypeID
                        ));
                        updateEBSOrdersRecordIds.add(ebsRecord.Id);
                    }
                }
				Boolean distributorChanged = oldEBSOrderMap != null && oldEBSOrderMap.containsKey(ebsRecord.Id) &&
    oldEBSOrderMap.get(ebsRecord.Id).Distributor_Account__c != ebsRecord.Distributor_Account__c;
                if (distributorChanged) {
    // Update the Sales Contact with the new Distributor Account
    updateSalesContactToNewDistributor(ebsRecord);
}
                // Sales Contact Logic
                if (ebsRecord.Sales_Contact__c != null) {
                    List<Contact> existingContacts = [
                        SELECT Id, Email, AccountId
                        FROM Contact
                        WHERE Email = :ebsRecord.Sales_Contact__c
                        LIMIT 1
                    ];

                   if (!existingContacts.isEmpty()) {
        Contact existingContact = existingContacts[0];

        // Check if Distributor_Account__c is present
        if (ebsRecord.Distributor_Account__c != null && 
            existingContact.AccountId != ebsRecord.Distributor_Account__c) {
            // Update the Contact's AccountId to Distributor_Account__c
            existingContact.AccountId = ebsRecord.Distributor_Account__c;
            update existingContact;

            // Tag the updated Contact to the EBS Order
            ebsRecord.SalesContact__c = existingContact.Id;
        } else {
            // If no Distributor Account change is required, tag the existing Contact
            ebsRecord.SalesContact__c = existingContact.Id;
        }

        // Add the record to the update list
        updateEBSOrdersRecordIds.add(ebsRecord.Id);
    } else {
                        Id salesContactAccountId = determineSalesContactAccount(ebsRecord);
                        if (salesContactAccountId != null) {
                            // Create new Sales Contact using the helper method
                            Contact newSalesContact = createSalesContact(ebsRecord, salesContactAccountId);
                            newContactList.add(newSalesContact);
                            updateEBSOrdersRecordIds.add(ebsRecord.Id);
                        }
                    }
                }
            }

            System.debug('===newContactList===' + newContactList);
            if (!newContactList.isEmpty() && !updateEBSOrdersRecordIds.isEmpty()) {
                insertNewContactList(newContactList);
                System.debug('Method called to insert');
            }
            if (!updateEBSOrdersRecordIds.isEmpty()) {
                isUpdated = true;
                updateEBSRecords(updateEBSOrdersRecordIds);
            }
        } catch (Exception ex) {
            System.debug('Exception in populateContactsOnOrder: ' + ex.getMessage());
            LogException.insertExceptionData('EBSOrderTriggerUtility', 'populateContactsOnOrder', null, ex);
        }
    }
}
    private static Id determineSalesContactAccount(EBS_Order__c ebsRecord) {
    // Check if the Account is a BDF and Distributor Account is provided
    if (ebsRecord.Account_Name__r.Customer_Class_Code__c == 'BDF') {
        if (ebsRecord.Distributor_Account__c != null) {
            return ebsRecord.Distributor_Account__c;
        } else {
            System.debug('Skipping Sales Contact creation for BDF due to missing Distributor_Account__c');
            return null; // Skip creation
        }
    }

    // For non-BDF accounts, use Account_Name__c or fallback to default
    return ebsRecord.Account_Name__c != null 
        ? ebsRecord.Account_Name__c 
        : koozieGroupAccountId;
}


 private static Contact createSalesContact(EBS_Order__c ebsRecord, Id accountId) {
    String contactFirstName = !String.isBlank(ebsRecord.Sales_Contact_First_Name__c)
        ? ebsRecord.Sales_Contact_First_Name__c
        : 'Valued';

    String contactLastName = !String.isBlank(ebsRecord.Sales_Contact_Last_Name__c)
        ? ebsRecord.Sales_Contact_Last_Name__c
        : 'Customer';

    return new Contact(
        FirstName = contactFirstName,
        LastName = contactLastName,
        AccountId = accountId,
        Email = ebsRecord.Sales_Contact__c,
        Is_Sales_Contact__c = true,
        RecordTypeId = recordTypeID
    );
}


    // Added: Method to update Sales Contact for the new Distributor Account
private static void updateSalesContactToNewDistributor(EBS_Order__c ebsRecord) {
    try {
        if (newContactMap.containsKey(ebsRecord.Sales_Contact__c)) {
            String contactId = newContactMap.get(ebsRecord.Sales_Contact__c);
            Contact contactToUpdate = new Contact(
                Id = contactId,
                AccountId = ebsRecord.Distributor_Account__c // Update to new Distributor Account
            );
            Database.update(contactToUpdate, false);
            System.debug('Sales Contact updated to new Distributor Account: ' + ebsRecord.Distributor_Account__c);
        } else {
            // If no existing contact is found in the map, query to find it and update
            List<Contact> existingContacts = [
                SELECT Id
                FROM Contact
                WHERE Email = :ebsRecord.Sales_Contact__c
                LIMIT 1
            ];

            if (!existingContacts.isEmpty()) {
                Contact contactToUpdate = new Contact(
                    Id = existingContacts[0].Id,
                    AccountId = ebsRecord.Distributor_Account__c
                );
                Database.update(contactToUpdate, false);
                System.debug('Sales Contact re-tagged to new Distributor Account: ' + ebsRecord.Distributor_Account__c);
            }
        }
    } catch (Exception ex) {
        System.debug('Exception in updateSalesContactToNewDistributor: ' + ex.getMessage());
    }
}


    
    /*
*	Description : Inserting new Contacts and Poplutong map keeping email as a key.
*/
 private static void insertNewContactList(List<Contact> newContactList) {
    system.debug('insertNewContactList called@@@@@@@@@@@');
    try {
        List<Contact> insertContactList = new List<Contact>();
        Map<String, Contact> existingContactMap = foundExistingContact(newContactList);
        Map<String, Contact> duplicateCheckMap = new Map<String, Contact>(); 

        // Add logic to collect emails from EBS_Order__c (Sales_Contact_Email__c)
        Set<String> emailSet = new Set<String>();
        for(Contact contactRecord : newContactList) {
            if(contactRecord.Email != null && !duplicateCheckMap.containsKey(recordTypeID + contactRecord.Email + contactRecord.AccountId)) {
                duplicateCheckMap.put(recordTypeID + contactRecord.Email + contactRecord.AccountId, contactRecord);
                emailSet.add(contactRecord.Email); // Collect emails for EBS_Order__c check
            }
        }

        // Query EBS_Order__c based on the Sales_Contact_Email__c
        Map<String, EBS_Order__c> ordersWithEmails = new Map<String, EBS_Order__c>(
            [SELECT Sales_Contact__c FROM EBS_Order__c WHERE Sales_Contact__c IN :emailSet]
        );

        // Loop through the duplicateCheckMap and check if the email exists in the EBS_Order__c emails
        for(Contact contactRecord : duplicateCheckMap.values()) {
            if(!existingContactMap.containsKey(recordTypeID + contactRecord.Email + contactRecord.AccountId) 
                && !ordersWithEmails.containsKey(contactRecord.Email)) {
                insertContactList.add(contactRecord);
            }
        }

        system.debug('insertNewContactList final @@@@@@@@@@@' + insertContactList);

        // Insert new contacts
        Database.SaveResult[] insertedContactResults = Database.insert(insertContactList, false);
        for (Integer i = 0; i < insertedContactResults.size(); i++) {
            if (insertedContactResults[i].isSuccess()) {
                successfullyInsertedContactList.add(insertContactList[i]);
                newContactMap.put(insertContactList[i].Email, insertContactList[i].Id);
            }
        }
    } catch (Exception ex) {
        System.debug('Exception in insertNewContactList: ' + ex.getMessage());
        LogException.insertExceptionData('EBSOrderTriggerUtility', 'insertNewContactList', null, ex);
    }
}

    /*
*	Description : populate the newly created contacts on all the 4 emails and update the EBS Order.
*/
    private static void updateEBSRecords(Set<Id> updateEBSOrdersRecordIds) {
        
        try{
            // Query to get EBS Order records
            List<EBS_Order__c> ebsRecordsToUpdate = [SELECT Id, Distributor_Account__c, Account_Name__r.Customer_Class_Code__c, Account_Name__c, PO_Contact__c, PO_Contact_Email__c, Order_Confirm_Contact__c, Order_Confirmation_Email__c, Shipping_Notif_Contact__c, Shipping_Notification_Email__c, SalesContact__c, Sales_Contact__c 
                                                     FROM EBS_Order__c 
                                                     WHERE Id IN :updateEBSOrdersRecordIds];
            
            // Collect Account IDs for the contacts to query
            Set<Id> accountIds = new Set<Id>();
            for (EBS_Order__c ebsRecord : ebsRecordsToUpdate) {
                if (ebsRecord.Distributor_Account__c != null) {
                    accountIds.add(ebsRecord.Distributor_Account__c);
                    System.debug('===accountIds==='+accountIds);
                }
                if (ebsRecord.Account_Name__c != null && ebsRecord.Distributor_Account__c == null) {
                    accountIds.add(ebsRecord.Account_Name__c);
                    System.debug('===accountIds==='+accountIds);
                }
            }
            
            // Query contacts related to the collected Account IDs
            Map<String, Id> contactEmailToIdMap = new Map<String, Id>();
            for (Contact contact : [SELECT Id, Email, AccountId 
                                    FROM Contact 
                                    WHERE AccountId IN :accountIds 
                                    AND Email != null]) {
                                        contactEmailToIdMap.put(contact.Email, contact.Id);
                                    }
            
            // Iterate over the EBS records and update the contact map
            for (EBS_Order__c ebsRecord : ebsRecordsToUpdate) {
                if (ebsRecord.Distributor_Account__c != null && contactEmailToIdMap.containsKey(ebsRecord.Sales_Contact__c)) {
                    newContactMap.put(ebsRecord.Sales_Contact__c, contactEmailToIdMap.get(ebsRecord.Sales_Contact__c));
                } /*else if (ebsRecord.Account_Name__c != null && ebsRecord.Distributor_Account__c == null && contactEmailToIdMap.containsKey(ebsRecord.Sales_Contact__c)) {
newContactMap.put(ebsRecord.Sales_Contact__c, contactEmailToIdMap.get(ebsRecord.Sales_Contact__c));
}*/
            }
            
            for (EBS_Order__c ebsRecord : ebsRecordsToUpdate) {
                system.debug('ebsRecord.Shipping_Notif_Contact__c@@@@@@@@@@'+ebsRecord.Sales_Contact__c);
                ebsRecord.PO_Contact__c = String.isBlank(ebsRecord.PO_Contact__c) ? newContactMap.get(ebsRecord.PO_Contact_Email__c) : ebsRecord.PO_Contact__c;
                ebsRecord.Order_Confirm_Contact__c = String.isBlank(ebsRecord.Order_Confirm_Contact__c) ? newContactMap.get(ebsRecord.Order_Confirmation_Email__c) : ebsRecord.Order_Confirm_Contact__c;
                ebsRecord.Shipping_Notif_Contact__c = String.isBlank(ebsRecord.Shipping_Notif_Contact__c) ? newContactMap.get(ebsRecord.Shipping_Notification_Email__c) : ebsRecord.Shipping_Notif_Contact__c;
                //ebsRecord.SalesContact__c = String.isBlank(ebsRecord.SalesContact__c) ? newContactMap.get(ebsRecord.Sales_Contact__c) : ebsRecord.SalesContact__c;
                //  ebsRecord.SalesContact__c = [select id from contact where email=:ebsRecord.Sales_Contact__c].id;
                if (!String.isBlank(ebsRecord.Sales_Contact__c) && 
                    ebsRecord.Distributor_Account__c != null && 
                    newContactMap.containsKey(ebsRecord.Sales_Contact__c)) {
                        ebsRecord.SalesContact__c = newContactMap.get(ebsRecord.Sales_Contact__c);
                    }
                if (!String.isBlank(ebsRecord.Sales_Contact__c) 
    && newContactMap.containsKey(ebsRecord.Sales_Contact__c)) {
    ebsRecord.SalesContact__c = newContactMap.get(ebsRecord.Sales_Contact__c);
}

                
                updateEBSOrderList.add(ebsRecord);
            }
            Database.SaveResult[] updatedEBSRecords = Database.update(updateEBSOrderList, false);
        }catch (Exception ex) {
            System.debug('Exception in updateEBSRecords: ' + ex.getMessage());
            LogException.insertExceptionData('EBSOrderTriggerUtility','updateEBSRecords',null,ex);
        }
    }
    private static Map<String,Contact> foundExistingContact(List<Contact> contactList){
        // Set<Id> accountIds = new Set<Id>();
        // Set<String> contactEmail = new Set<String>();
        Map<String,Contact> foundExistingContactMap = new Map<String,Contact>();
        try{
            Set<Id> accountIds = new Set<Id>();
            Set<String> contactEmail = new Set<String>();
            for(Contact contactRecord : contactList){
                if(contactRecord.AccountId!=null && contactRecord.Email!=null){
                    accountIds.add(contactRecord.AccountId);
                    contactEmail.add(contactRecord.Email);
                }
            }
            if(!accountIds.isEmpty() && !contactEmail.isEmpty()){
                List<Contact> existingContactList = [SELECT Id,Email,AccountId FROM Contact WHERE AccountId IN: accountIds AND Email IN:contactEmail AND RecordTypeId =:recordTypeID];
                
                for(Contact contactRecord: existingContactList){
                    if(!foundExistingContactMap.containsKey(recordTypeID+contactRecord.Email+contactRecord.AccountId)){
                        foundExistingContactMap.put(recordTypeID+contactRecord.Email+contactRecord.AccountId,contactRecord);
                    }  
                } 
            }
        }catch (Exception ex) {
            System.debug('Exception in foundExistingContact: ' + ex.getMessage());
            LogException.insertExceptionData('EBSOrderTriggerUtility','foundExistingContact',null,ex);
        }
        return foundExistingContactMap;
    }
}