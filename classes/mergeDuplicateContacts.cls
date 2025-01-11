/**
 * @description       : 
 * @author            : Ritesh Kumar
 * @group             : 
 * @last modified on  : 06-05-2024
 * @last modified by  : Ritesh Kumar
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   06-05-2024   Ritesh Kumar   Initial Version
**/
public without sharing class mergeDuplicateContacts implements Database.Batchable<AggregateResult>, Database.stateful,Schedulable{
    /*
    * Description : CRM Record Type Id
    */
    public static final Id CRM_CONTACT = KoozieUtility.getRecordTypeId('Contact', 'CRM Contact');
    /*
    * Description : Fetching Info from Contact Merge Batch Custom Setting 
    */
    Contact_Batch_Jobs__c cbj = Contact_Batch_Jobs__c.getValues('Contact Merge Batch');
    /*
    *	Description : Stateful Variables to keep track of contacts which are verifed or has webID.
    */
    public static Set<Id> duplicateKeyWebSet = new Set<Id>();
    public static Set<Id> duplicateKeyVerifiedSet = new Set<Id>();
    /*
    *	Description : Scheduling the Batch Class, it will execute in every 6 hours
    */
    public void execute(SchedulableContext cx){ 
        Database.executeBatch(new mergeDuplicateContacts(), (Integer)cbj.Batch_Size__c);
    } 
    /*
    *	Description : Return all the CRM RecordType Contacts from the Accounts.
    */
    public Iterable<AggregateResult> start(Database.BatchableContext bc){
        String soqlQuery = 'SELECT COUNT(Id),Email,AccountId FROM Contact';
        if(cbj.Batch_Filter__c == 'TODAY'){ 
            soqlQuery += ' WHERE CreatedDate = TODAY AND Email!=null AND RecordTypeId =:CRM_CONTACT GROUP BY Email,AccountId HAVING COUNT(Id) > 1 Order BY Count(Id) DESC';
        }else{
            soqlQuery += ' WHERE Email!=null AND RecordTypeId =:CRM_CONTACT GROUP BY Email,AccountId HAVING COUNT(Id) > 1 ORDER BY Count(Id) DESC';
        }
        return new AggregateResultIterable(soqlQuery);
    }
    /*
    *	Description : Selecting the Master contact from the Duplicate Contacts basde on WebID,Verified and last modifed Criteria.
    */
    public void execute(Database.BatchableContext bc, List<AggregateResult> contactList){
        Set<String> accountIds = new Set<String>();
        Set<String> duplicateKeySet = new Set<String>();
        Map<String,List<Contact>> neglectContactMergeMap = new Map<String,List<Contact>>();
        Map<String, List<Contact>> emailContactMap = new Map<String, List<Contact>>();
        Map<Contact, List<Id>> mergeMap = new Map<Contact, List<Id>>();
        /*
        *	Description : Constructing Duplicate Key from All Contacts : RecordtypeID+Email+AccountID
        */
        for(AggregateResult record : contactList){         
            String duplicateKey = ''; 
            if(String.isNotBlank(CRM_CONTACT)){
                duplicateKey += CRM_CONTACT;
            }
            if(String.isNotBlank(String.valueOf(record.get('Email')))){
                duplicateKey += String.valueOf(record.get('Email'));
            }
            if(String.isNotBlank(String.valueOf(record.get('AccountId')))){
                duplicateKey += String.valueOf(record.get('AccountId'));
            }
            duplicateKeySet.add(duplicateKey.toLowerCase().trim()); 
            accountIds.add(String.valueOf(record.get('AccountId')));
        }
        /*
        *	Description : Filtering all the CRM Contact Which has Duplicate_Record_Formula__c = Duplicate KEY
        */
        if(duplicateKeySet.size() >= 1){
            List<Contact> conList = [SELECT Id, Web_Id__c,Verified__c,RecordTypeId,isBatchRunning__c,Merge_Contact_Id_s__c, Source_ID__c, AccountId, Active_Flag__c,  
            Address_Site__c, Address_Status__c, Address_Type__c, Address1_ID__c, Address2_ID__c, Address3_ID__c, Address4_ID__c, Age_Group__c, 
            ASI_Number__c,  Bic__c, Bic_Graphic_Canada_Catalog_Eng__c, Bic_Graphic_Canada_Catalog_FRE__c, Bic_Graphic_Canada_Cycle_Flyer_ENG__c, 
            Bic_Graphic_Canada_Cycle_Flyer_FRE__c, Bic_Graphic_Catalog__c, Bic_Graphic_Catalog_with_Logo__c, Bic_Graphic_Catalog_with_Logo_Canada__c, 
            Bic_Graphic_Cycle_Flyer__c, Bic_Graphic_Cycle_Flyer_with_Logo__c, Bic_Graphic_Cycle_Flyer_with_Logo_Can__c, Bic_Graphic_Triumph_GV_Calendars_Canada__c, 
            Bic_Graphic_Triumph_GV_Calendars_Cat__c,  Bounce_Count__c, Calendar_Sample_Kit_CAN__c, Calendar_Sample_Kit_US__c, Case_Studies__c, Closeout_Updates__c, 
            Communication_Styles__c,    Contact_Status__c, Contact_Type__c, County__c,   Data_Import__c, Data_Upload_Identifier__c, Date_Verified__c, Department,  
            Discounts__c, Discover_Guides__c, Do_Not_Call_For_Clarifications__c, Do_Not_Mail__c, DOB__c,  Email, EmailBouncedDate, EmailBouncedReason, EmailID__c, Fax, 
            FaxID__c, First_Created_Date__c, FirstName, Flyers_Special_Offers__c, Gender__c, HasOptedOutOfEmail, IndividualId,   Jigsaw, JigsawContactId,  LastName,  
            Line_Total__c, MailingCity, MailingCountry, MailingGeocodeAccuracy, MailingLatitude, MailingLongitude, MailingPostalCode, MailingState, MailingStreet, 
            Master_Merge__c, MasterRecordId,  MergePriority__c, MiddleName, Mkt__c, Mktg_Address_City__c, Mktg_Address_Country__c, Mktg_Address_Customer_Verified__c, 
            Mktg_Address_State_Province__c, Mktg_Address_Street__c, Mktg_Address_Verification_Date__c, Mktg_Address_Zip_Postal_Code__c, MOB_Opt_Out__c, MobilePhone, 
            Motivator_On_Board__c,  New_Product_Information__c, Newsletters__c, Norwood__c, Not_Duplicate__c, Onboarding_Opt_Out__c, Other_Email__c,  OtherCity,
            OtherCountry, OtherGeocodeAccuracy, OtherLatitude, OtherLongitude, OtherPhone, OtherPhoneID__c, OtherPostalCode, OtherState, OtherStreet, OwnerId, Phone, 
            PhoneID__c, Preferred_Channel__c, Preferred_Contact__c, Preferred_Phone_Number__c,  Primary_ID__c, Primary_Responsibility_Flag__c, PrimaryEmailFlag__c, 
            PrimaryFaxFlag__c, PrimaryOtherEmailFlag__c, PrimaryOtherPhoneFlag__c, PrimaryPhoneFlag__c, Product_Knowledge__c, PromoStandards_Contact__c, Purchaser__c, 
            Random_Samples_Journey__c, ReportsToId,  Responsibility_Type__c,  Salutation, Samples__c, Secondary_Contact_Type__c, SFSSDupeCatcher__Override_DupeCatcher__c, 
            Shared_Email__c, Source__c, Storyboards__c, Suffix,  Title, Top_Producer__c, Website__c, Weekly_USB_Pricing__c 
            FROM Contact 
            WHERE Duplicate_Record_Formula__c IN: duplicateKeySet AND AccountId IN: accountIds 
            AND RecordType.Name = 'CRM Contact' AND Email!=null AND AccountID!=null AND RecordTypeId!=null ORDER BY LastModifiedDate ASC];
            /*
            *	Description : pouplating webID set and verified set with contact Ids
            */
            for (Contact record : conList) {
                if (record.Web_Id__c != null) {
                    duplicateKeyWebSet.add(record.Id); 
                } else if (record.Verified__c != false) {
                    duplicateKeyVerifiedSet.add(record.Id); 
                }
            }   
            /*
            *	Description : Finding the Master Contact from the dupplicate contacts and keeping the master contact at index 0 in the list of duplicate contacts
            */
            if(!conList.isEmpty()){
                for(Contact record : conList){
                    record.isBatchRunning__c = true; 
                    String duplicateKey = ''; 
                    if(String.isNotBlank(CRM_CONTACT)){
                    duplicateKey += CRM_CONTACT;
                    }
                    if(String.isNotBlank(record.Email)){
                        duplicateKey += record.Email;
                    }
                    if(String.isNotBlank(record.AccountId)){
                        duplicateKey += record.AccountId;
                    }
                    String dup = duplicateKey.toLowerCase().trim();
                    if (duplicateKeyWebSet.contains(record.Id)) {
                        if(!emailContactMap.containsKey(dup)){
                            emailContactMap.put(dup, new List<Contact>{record}); 
                        }else if(emailContactMap.containsKey(dup)){
                            List<Contact> priorityWebContacts = emailContactMap.get(dup);
                            priorityWebContacts.add(0,record);
                            emailContactMap.put(dup, priorityWebContacts); 
                        }
                    } else if (duplicateKeyVerifiedSet.contains(record.Id)) {
                        if(!emailContactMap.containsKey(dup)){
                            emailContactMap.put(dup, new List<Contact>{record}); 
                        }else if(emailContactMap.containsKey(dup)){
                            List<Contact> priorityVerifiedContacts = emailContactMap.get(dup);
                            if(priorityVerifiedContacts[0].Web_Id__c==null){
                                priorityVerifiedContacts.add(0,record);
                                emailContactMap.put(dup, priorityVerifiedContacts); 
                            }else{
                                priorityVerifiedContacts.add(record);
                                emailContactMap.put(dup, priorityVerifiedContacts); 
                            }
                        }
                    } else {
                        if (emailContactMap.containsKey(dup)) {
                            List<Contact> existingContacts = emailContactMap.get(dup);
                            if(existingContacts[0].Web_Id__c==null && existingContacts[0].Verified__c==false){
                                existingContacts.add(0,record);
                                emailContactMap.put(dup, existingContacts);
                                // // // System.debug('Existing Contact 2:::: '+existingContacts.get(0).Id);
                            }else{
                                existingContacts.add(record);
                                emailContactMap.put(dup, existingContacts);
                            }
                        } else {
                            List<Contact> newContacts = new List<Contact>();
                            newContacts.add(record);
                            emailContactMap.put(dup, newContacts);
                            // // // System.debug('Existing Contact 1 :::: '+newContacts.get(0).Id);
                        }   
                    } 
                }
                mergeMap.clear();  
            }
        } 
        /*
        *	Description : Removing those keys,values from the map which dosent have any duplicate contact
        */
        for(String dupkey: emailContactMap.keySet()){
            if(emailContactMap.get(dupkey).size()==1){
                emailContactMap.remove(dupkey);
            }
        }
        /*
        *	Description :  Sending Email Alert if more than 1 duplicate contacts are found with web ids. Also ignore the merging for those duplicates
        */
        for(String dupkey:emailContactMap.keySet()){
            if(emailContactMap.get(dupkey).size()>1){
                for(Contact contactRecord: emailContactMap.get(dupkey)){
                    if(contactRecord.Web_Id__c!=null){
                        if(!neglectContactMergeMap.containsKey(dupkey)){
                            neglectContactMergeMap.put(dupkey,new List<Contact>{contactRecord});
                        }else if(neglectContactMergeMap.containsKey(dupkey)){
                            List<Contact> exContacts = neglectContactMergeMap.get(dupkey);
                            exContacts.add(contactRecord);
                            neglectContactMergeMap.put(dupkey,exContacts);
                        }
                    }
                }
                if(neglectContactMergeMap.containsKey(dupkey) && neglectContactMergeMap.get(dupkey).size()>=2){
                    emailContactMap.remove(dupkey);
                }else if(neglectContactMergeMap.containsKey(dupkey) && neglectContactMergeMap.get(dupkey).size()<=1){
                    neglectContactMergeMap.remove(dupkey);
                }
            }
        }
        if(neglectContactMergeMap!=null){
            sendMail(cbj.User_Email_Address__c,'Duplicate Contacts with Web Ids',neglectContactMergeMap);
        }
        /*
        *	Description : Merging the Duplicate Contacts depnding on the size of the list
        *               : Limitation of Database.Merge : can only merge 3 contacts at a time including the master.
        *               : Mapping all the fields of the loosing Conatcts in the Master Contact. 
        */
        if(emailContactMap != null){
            for(String duplicateKey : emailContactMap.keySet()){
                Boolean isFirst = true;
                Contact masterContact = new Contact();
                if(emailContactMap.get(duplicateKey).size() <=3 && emailContactMap.get(duplicateKey).size() > 1){
                    for(Contact record : emailContactMap.get(duplicateKey)){ 
                        if(isFirst){
                            masterContact = record;
                            isFirst= false; 
                        }
                        else{ 
                            if(masterContact.Suffix == null){
                                masterContact.Suffix = record.Suffix;
                            } 

                            if(masterContact.Fax == null){
                                masterContact.Fax = record.Fax;
                            } 

                            if(masterContact.Phone == null){
                                masterContact.Phone = record.Phone;
                            }
                            
                            if(masterContact.MobilePhone == null){
                                masterContact.MobilePhone = record.MobilePhone;
                            } 
                            
                            if(masterContact.Active_Flag__c == null){
                                masterContact.Active_Flag__c = record.Active_Flag__c;
                            }
                            
                            if(masterContact.Address_Site__c == null){
                                masterContact.Address_Site__c = record.Address_Site__c;
                            }
                            
                            if(masterContact.Address_Status__c == null){
                                masterContact.Address_Status__c = record.Address_Status__c;
                            }
                            
                            if(masterContact.Address_Type__c == null){
                                masterContact.Address_Type__c = record.Address_Type__c;
                            }
                            
                            if(masterContact.Address1_ID__c == null){
                                masterContact.Address1_ID__c = record.Address1_ID__c;
                            }
                            
                            if(masterContact.Address2_ID__c == null){
                                masterContact.Address2_ID__c = record.Address2_ID__c;
                            }
                            
                            if(masterContact.Address3_ID__c == null){
                                masterContact.Address3_ID__c = record.Address3_ID__c;
                            }
                            
                            if(masterContact.Address4_ID__c == null){
                                masterContact.Address4_ID__c = record.Address4_ID__c;
                            }
                            
                            if(masterContact.Age_Group__c == null){
                                masterContact.Age_Group__c = record.Age_Group__c;
                            }
                            
                            if(masterContact.ASI_Number__c == null){
                                masterContact.ASI_Number__c = record.ASI_Number__c;
                            }
                            
                            if(masterContact.Bounce_Count__c == null){
                                masterContact.Bounce_Count__c = record.Bounce_Count__c;
                            }
                            
                            if(masterContact.Calendar_Sample_Kit_CAN__c == null){
                                masterContact.Calendar_Sample_Kit_CAN__c = record.Calendar_Sample_Kit_CAN__c;
                            }

                            if(masterContact.Case_Studies__c == null){
                                masterContact.Case_Studies__c = record.Case_Studies__c;
                            }
                            
                            if(masterContact.Closeout_Updates__c == null){
                                masterContact.Closeout_Updates__c = record.Closeout_Updates__c;
                            }
                            
                            if(masterContact.Communication_Styles__c == null){
                                masterContact.Communication_Styles__c = record.Communication_Styles__c;
                            }
                            
                            if(masterContact.SFSSDupeCatcher__Override_DupeCatcher__c == null){
                                masterContact.SFSSDupeCatcher__Override_DupeCatcher__c = record.SFSSDupeCatcher__Override_DupeCatcher__c;
                            }

                            if(masterContact.Contact_Status__c == null){
                                masterContact.Contact_Status__c = record.Contact_Status__c;
                            }
                            
                            if(masterContact.Contact_Type__c == null){
                                masterContact.Contact_Type__c = record.Contact_Type__c;
                            }
                            
                            if(masterContact.County__c == null){
                                masterContact.County__c = record.County__c;
                            } 

                            if(masterContact.Data_Import__c == null){
                                masterContact.Data_Import__c = record.Data_Import__c;
                            } 

                            if(masterContact.Data_Upload_Identifier__c == null){
                                masterContact.Data_Upload_Identifier__c = record.Data_Upload_Identifier__c;
                            }
                            
                            if(masterContact.Date_Verified__c == null){
                                masterContact.Date_Verified__c = record.Date_Verified__c;
                            }
                            
                            if(masterContact.Discounts__c == null){
                                masterContact.Discounts__c = record.Discounts__c;
                            }
                            
                            if(masterContact.Discover_Guides__c == null){
                                masterContact.Discover_Guides__c = record.Discover_Guides__c;
                            }
                            
                            if(masterContact.Do_Not_Call_For_Clarifications__c == null){
                                masterContact.Do_Not_Call_For_Clarifications__c = record.Do_Not_Call_For_Clarifications__c;
                            }
                            
                            if(masterContact.Do_Not_Mail__c == null){
                                masterContact.Do_Not_Mail__c = record.Do_Not_Mail__c;
                            }
                            
                            if(masterContact.DOB__c == null){
                                masterContact.DOB__c = record.DOB__c;
                            } 
                            
                            if(masterContact.EmailID__c == null){
                                masterContact.EmailID__c = record.EmailID__c;
                            }
                            
                            if(masterContact.FaxID__c == null){
                                masterContact.FaxID__c = record.FaxID__c;
                            }
                            
                            if(masterContact.First_Created_Date__c== null){
                                masterContact.First_Created_Date__c = record.First_Created_Date__c;
                            }
                            
                            if(masterContact.Flyers_Special_Offers__c == null){
                                masterContact.Flyers_Special_Offers__c = record.Flyers_Special_Offers__c;
                            }
                            
                            if(masterContact.Gender__c == null){
                                masterContact.Gender__c = record.Gender__c;
                            }
                            
                            if(masterContact.Bic__c == null){
                                masterContact.Bic__c = record.Bic__c;
                            }  
                            
                            if(masterContact.Bic_Graphic_Cycle_Flyer_with_Logo_Can__c == null){
                                masterContact.Bic_Graphic_Cycle_Flyer_with_Logo_Can__c = record.Bic_Graphic_Cycle_Flyer_with_Logo_Can__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Canada_Cycle_Flyer_ENG__c == null){
                                masterContact.Bic_Graphic_Canada_Cycle_Flyer_ENG__c = record.Bic_Graphic_Canada_Cycle_Flyer_ENG__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Canada_Cycle_Flyer_FRE__c == null){
                                masterContact.Bic_Graphic_Canada_Cycle_Flyer_FRE__c = record.Bic_Graphic_Canada_Cycle_Flyer_FRE__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Cycle_Flyer__c == null){
                                masterContact.Bic_Graphic_Cycle_Flyer__c = record.Bic_Graphic_Cycle_Flyer__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Cycle_Flyer_with_Logo__c == null){
                                masterContact.Bic_Graphic_Cycle_Flyer_with_Logo__c = record.Bic_Graphic_Cycle_Flyer_with_Logo__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Triumph_GV_Calendars_Cat__c == null){
                                masterContact.Bic_Graphic_Triumph_GV_Calendars_Cat__c = record.Bic_Graphic_Triumph_GV_Calendars_Cat__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Triumph_GV_Calendars_Canada__c == null){
                                masterContact.Bic_Graphic_Triumph_GV_Calendars_Canada__c = record.Bic_Graphic_Triumph_GV_Calendars_Canada__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Catalog__c == null){
                                masterContact.Bic_Graphic_Catalog__c = record.Bic_Graphic_Catalog__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Catalog_with_Logo__c == null){
                                masterContact.Bic_Graphic_Catalog_with_Logo__c = record.Bic_Graphic_Catalog_with_Logo__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Catalog_with_Logo_Canada__c == null){
                                masterContact.Bic_Graphic_Catalog_with_Logo_Canada__c = record.Bic_Graphic_Catalog_with_Logo_Canada__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Canada_Catalog_Eng__c == null){
                                masterContact.Bic_Graphic_Canada_Catalog_Eng__c = record.Bic_Graphic_Canada_Catalog_Eng__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Canada_Catalog_FRE__c == null){
                                masterContact.Bic_Graphic_Canada_Catalog_FRE__c = record.Bic_Graphic_Canada_Catalog_FRE__c;
                            }
                            
                            if(masterContact.Line_Total__c == null){
                                masterContact.Line_Total__c = record.Line_Total__c;
                            }
                            
                            if(masterContact.Master_Merge__c == null){
                                masterContact.Master_Merge__c = record.Master_Merge__c;
                            } 
                            
                            if(masterContact.MergePriority__c == null){
                                masterContact.MergePriority__c = record.MergePriority__c;
                            }
                            
                            if(masterContact.Mkt__c == null){
                                masterContact.Mkt__c = record.Mkt__c;
                            }
                            
                            if(masterContact.Mktg_Address_City__c == null){
                                masterContact.Mktg_Address_City__c = record.Mktg_Address_City__c;
                            }
                            
                            if(masterContact.Mktg_Address_Country__c == null){
                                masterContact.Mktg_Address_Country__c = record.Mktg_Address_Country__c;
                            }
                            
                            if(masterContact.Mktg_Address_Customer_Verified__c == null){
                                masterContact.Mktg_Address_Customer_Verified__c = record.Mktg_Address_Customer_Verified__c;
                            }
                            
                            if(masterContact.Mktg_Address_State_Province__c == null){
                                masterContact.Mktg_Address_State_Province__c = record.Mktg_Address_State_Province__c;
                            }
                            
                            if(masterContact.Mktg_Address_Street__c == null){
                                masterContact.Mktg_Address_Street__c = record.Mktg_Address_Street__c;
                            }
                            
                            if(masterContact.Mktg_Address_Verification_Date__c == null){
                                masterContact.Mktg_Address_Verification_Date__c = record.Mktg_Address_Verification_Date__c;
                            }
                            if(masterContact.Mktg_Address_Zip_Postal_Code__c == null){
                                masterContact.Mktg_Address_Zip_Postal_Code__c = record.Mktg_Address_Zip_Postal_Code__c;
                            }
                            
                            if(masterContact.MOB_Opt_Out__c == null){
                                masterContact.MOB_Opt_Out__c = record.MOB_Opt_Out__c;
                            }
                            
                            if(masterContact.Motivator_On_Board__c == null){
                                masterContact.Motivator_On_Board__c = record.Motivator_On_Board__c;
                            }
                            
                            if(masterContact.New_Product_Information__c == null){
                                masterContact.New_Product_Information__c = record.New_Product_Information__c;
                            }
                            
                            if(masterContact.Newsletters__c == null){
                                masterContact.Newsletters__c = record.Newsletters__c;
                            }
                            
                            if(masterContact.Norwood__c == null){
                                masterContact.Norwood__c = record.Norwood__c;
                            }
                            
                            if(masterContact.Not_Duplicate__c == null){
                                masterContact.Not_Duplicate__c = record.Not_Duplicate__c;
                            }
                            
                            if(masterContact.Onboarding_Opt_Out__c == null){
                                masterContact.Onboarding_Opt_Out__c = record.Onboarding_Opt_Out__c;
                            }
                            
                            if(masterContact.Other_Email__c == null){
                                masterContact.Other_Email__c = record.Other_Email__c;
                            } 
                            
                            if(masterContact.OtherPhoneID__c == null){
                                masterContact.OtherPhoneID__c = record.OtherPhoneID__c;
                            } 

                            if(masterContact.Preferred_Channel__c == null){
                                masterContact.Preferred_Channel__c = record.Preferred_Channel__c;
                            }
                            
                            if(masterContact.Preferred_Contact__c == null){
                                masterContact.Preferred_Contact__c = record.Preferred_Contact__c;
                            }
                            
                            if(masterContact.Preferred_Phone_Number__c == null){
                                masterContact.Preferred_Phone_Number__c = record.Preferred_Phone_Number__c;
                            }
                            
                            if(masterContact.Primary_ID__c == null){
                                masterContact.Primary_ID__c = record.Primary_ID__c;
                            }
                            
                            if(masterContact.PrimaryOtherEmailFlag__c == null){
                                masterContact.PrimaryOtherEmailFlag__c = record.PrimaryOtherEmailFlag__c;
                            }
                            
                            if(masterContact.Primary_Responsibility_Flag__c == null){
                                masterContact.Primary_Responsibility_Flag__c = record.Primary_Responsibility_Flag__c;
                            }
                            
                            if(masterContact.PrimaryEmailFlag__c == null){
                                masterContact.PrimaryEmailFlag__c = record.PrimaryEmailFlag__c;
                            }
                            
                            if(masterContact.PrimaryFaxFlag__c == null){
                                masterContact.PrimaryFaxFlag__c = record.PrimaryFaxFlag__c;
                            }
                            
                            if(masterContact.PrimaryOtherPhoneFlag__c == null){
                                masterContact.PrimaryOtherPhoneFlag__c = record.PrimaryOtherPhoneFlag__c;
                            }
                            
                            if(masterContact.PrimaryPhoneFlag__c == null){
                                masterContact.PrimaryPhoneFlag__c = record.PrimaryPhoneFlag__c;
                            }
                            
                            if(masterContact.Product_Knowledge__c == null){
                                masterContact.Product_Knowledge__c = record.Product_Knowledge__c;
                            }
                            
                            if(masterContact.PromoStandards_Contact__c == null){
                                masterContact.PromoStandards_Contact__c = record.PromoStandards_Contact__c;
                            } 

                            if(masterContact.Purchaser__c == null){
                                masterContact.Purchaser__c = record.Purchaser__c;
                            }
                            
                            if(masterContact.Random_Samples_Journey__c == null){
                                masterContact.Random_Samples_Journey__c = record.Random_Samples_Journey__c;
                            } 

                            if(masterContact.Responsibility_Type__c == null){
                                masterContact.Responsibility_Type__c = record.Responsibility_Type__c;
                            } 

                            if(masterContact.Samples__c == null){
                                masterContact.Samples__c = record.Samples__c;
                            }
                            
                            if(masterContact.Secondary_Contact_Type__c == null){
                                masterContact.Secondary_Contact_Type__c = record.Secondary_Contact_Type__c;
                            }
                            
                            if(masterContact.Shared_Email__c == null){
                                masterContact.Shared_Email__c = record.Shared_Email__c;
                            }

                            if(masterContact.Source__c == null){
                                masterContact.Source__c = record.Source__c;
                            }
                            
                            if(masterContact.Source_ID__c == null){
                                masterContact.Source_ID__c = record.Source_ID__c;
                            }
                            
                            if(masterContact.Storyboards__c == null){
                                masterContact.Storyboards__c = record.Storyboards__c;
                            } 
                            
                            if(masterContact.Top_Producer__c == null){
                                masterContact.Top_Producer__c = record.Top_Producer__c;
                            } 

                            if(masterContact.Verified__c != true){
                                masterContact.Verified__c = record.Verified__c;
                            }
                            
                            if(masterContact.Website__c == null){
                                masterContact.Website__c = record.Website__c;
                            }
                            
                            if(masterContact.Weekly_USB_Pricing__c == null){
                                masterContact.Weekly_USB_Pricing__c = record.Weekly_USB_Pricing__c;
                            }
                            
                            if(masterContact.Title == null){
                                masterContact.Title = record.Title;
                            }
                            
                            if(masterContact.MailingStreet == null){
                                masterContact.MailingStreet = record.MailingStreet;
                            }
                            
                            if(masterContact.MailingCity == null){
                                masterContact.MailingCity = record.MailingCity;
                            }
                            
                            if(masterContact.MailingState == null){
                                masterContact.MailingState = record.MailingState;
                            }
                            
                            if(masterContact.MailingCountry == null){
                                masterContact.MailingCountry = record.MailingCountry;
                            }
                            
                            if(masterContact.MailingPostalCode == null){
                                masterContact.MailingPostalCode = record.MailingPostalCode;
                            }
                            
                            if(mergeMap.containsKey(record)){
                                mergeMap.get(masterContact).add(record.Id);
                            }else{
                                mergeMap.put(masterContact, new List<Id>{record.Id});
                            }
                        }
                    }                    
                }
                
                else if(emailContactMap.get(duplicateKey).size() > 3){
                    for(Integer index = 0 ; index < 3 ; index++){
                        if(isFirst){
                            masterContact = emailContactMap.get(duplicateKey)[index];
                            isFirst= false;
                        }else{

                            if(masterContact.Phone == null){
                                masterContact.Phone = emailContactMap.get(duplicateKey)[index].Phone;
                            } 
                            
                            if(masterContact.Fax == null){
                                masterContact.Fax = emailContactMap.get(duplicateKey)[index].Fax;
                            } 
                                                        
                            if(masterContact.MobilePhone == null){
                                masterContact.MobilePhone = emailContactMap.get(duplicateKey)[index].MobilePhone;
                            } 
                            
                            if(masterContact.Suffix == null){
                                masterContact.Suffix = emailContactMap.get(duplicateKey)[index].Suffix;
                            }  
                            
                            if(masterContact.Active_Flag__c == null){
                                masterContact.Active_Flag__c = emailContactMap.get(duplicateKey)[index].Active_Flag__c;
                            }
                            
                            if(masterContact.Address_Site__c == null){
                                masterContact.Address_Site__c = emailContactMap.get(duplicateKey)[index].Address_Site__c;
                            }
                            
                            if(masterContact.Address_Status__c == null){
                                masterContact.Address_Status__c = emailContactMap.get(duplicateKey)[index].Address_Status__c;
                            }
                            
                            if(masterContact.Address_Type__c == null){
                                masterContact.Address_Type__c = emailContactMap.get(duplicateKey)[index].Address_Type__c;
                            }
                            
                            if(masterContact.Address1_ID__c == null){
                                masterContact.Address1_ID__c = emailContactMap.get(duplicateKey)[index].Address1_ID__c;
                            }
                            
                            if(masterContact.Address2_ID__c == null){
                                masterContact.Address2_ID__c = emailContactMap.get(duplicateKey)[index].Address2_ID__c;
                            }
                            
                            if(masterContact.Address3_ID__c == null){
                                masterContact.Address3_ID__c = emailContactMap.get(duplicateKey)[index].Address3_ID__c;
                            }
                            
                            if(masterContact.Address4_ID__c == null){
                                masterContact.Address4_ID__c = emailContactMap.get(duplicateKey)[index].Address4_ID__c;
                            }
                            
                            if(masterContact.Age_Group__c == null){
                                masterContact.Age_Group__c = emailContactMap.get(duplicateKey)[index].Age_Group__c;
                            }
                            
                            if(masterContact.ASI_Number__c == null){
                                masterContact.ASI_Number__c = emailContactMap.get(duplicateKey)[index].ASI_Number__c;
                            }
                            
                            if(masterContact.Bounce_Count__c == null){
                                masterContact.Bounce_Count__c = emailContactMap.get(duplicateKey)[index].Bounce_Count__c;
                            }
                            
                            if(masterContact.Calendar_Sample_Kit_CAN__c == null){
                                masterContact.Calendar_Sample_Kit_CAN__c = emailContactMap.get(duplicateKey)[index].Calendar_Sample_Kit_CAN__c;
                            } 

                            if(masterContact.Case_Studies__c == null){
                                masterContact.Case_Studies__c = emailContactMap.get(duplicateKey)[index].Case_Studies__c;
                            }
                            
                            if(masterContact.Closeout_Updates__c == null){
                                masterContact.Closeout_Updates__c = emailContactMap.get(duplicateKey)[index].Closeout_Updates__c;
                            }
                            
                            if(masterContact.Communication_Styles__c == null){
                                masterContact.Communication_Styles__c = emailContactMap.get(duplicateKey)[index].Communication_Styles__c;
                            }
                            
                            if(masterContact.SFSSDupeCatcher__Override_DupeCatcher__c == null){
                                masterContact.SFSSDupeCatcher__Override_DupeCatcher__c = emailContactMap.get(duplicateKey)[index].SFSSDupeCatcher__Override_DupeCatcher__c;
                            }
                            
                            if(masterContact.Contact_Status__c == null){
                                masterContact.Contact_Status__c = emailContactMap.get(duplicateKey)[index].Contact_Status__c;
                            }
                            
                            if(masterContact.Contact_Type__c == null){
                                masterContact.Contact_Type__c = emailContactMap.get(duplicateKey)[index].Contact_Type__c;
                            }
                            
                            if(masterContact.County__c == null){
                                masterContact.County__c = emailContactMap.get(duplicateKey)[index].County__c;
                            } 
                            
                            if(masterContact.Data_Import__c == null){
                                masterContact.Data_Import__c = emailContactMap.get(duplicateKey)[index].Data_Import__c;
                            }
                            
                            if(masterContact.Data_Upload_Identifier__c == null){
                                masterContact.Data_Upload_Identifier__c = emailContactMap.get(duplicateKey)[index].Data_Upload_Identifier__c;
                            }
                            
                            if(masterContact.Date_Verified__c == null){
                                masterContact.Date_Verified__c = emailContactMap.get(duplicateKey)[index].Date_Verified__c;
                            }
                            
                            if(masterContact.Discounts__c == null){
                                masterContact.Discounts__c = emailContactMap.get(duplicateKey)[index].Discounts__c;
                            }
                            
                            if(masterContact.Discover_Guides__c == null){
                                masterContact.Discover_Guides__c = emailContactMap.get(duplicateKey)[index].Discover_Guides__c;
                            }
                            
                            if(masterContact.Do_Not_Call_For_Clarifications__c == null){
                                masterContact.Do_Not_Call_For_Clarifications__c = emailContactMap.get(duplicateKey)[index].Do_Not_Call_For_Clarifications__c;
                            }
                            
                            if(masterContact.Do_Not_Mail__c == null){
                                masterContact.Do_Not_Mail__c = emailContactMap.get(duplicateKey)[index].Do_Not_Mail__c;
                            }
                            
                            if(masterContact.DOB__c == null){
                                masterContact.DOB__c = emailContactMap.get(duplicateKey)[index].DOB__c;
                            } 
                            
                            if(masterContact.EmailID__c == null){
                                masterContact.EmailID__c = emailContactMap.get(duplicateKey)[index].EmailID__c;
                            }
                            
                            if(masterContact.FaxID__c == null){
                                masterContact.FaxID__c = emailContactMap.get(duplicateKey)[index].FaxID__c;
                            }
                            
                            if(masterContact.First_Created_Date__c== null){
                                masterContact.First_Created_Date__c = emailContactMap.get(duplicateKey)[index].First_Created_Date__c;
                            }
                            
                            if(masterContact.Flyers_Special_Offers__c == null){
                                masterContact.Flyers_Special_Offers__c = emailContactMap.get(duplicateKey)[index].Flyers_Special_Offers__c;
                            }
                            
                            if(masterContact.Gender__c == null){
                                masterContact.Gender__c = emailContactMap.get(duplicateKey)[index].Gender__c;
                            }
                                
                            if(masterContact.Bic__c == null){
                                masterContact.Bic__c = emailContactMap.get(duplicateKey)[index].Bic__c;
                            }  
                            
                            if(masterContact.Bic_Graphic_Cycle_Flyer_with_Logo_Can__c == null){
                                masterContact.Bic_Graphic_Cycle_Flyer_with_Logo_Can__c = emailContactMap.get(duplicateKey)[index].Bic_Graphic_Cycle_Flyer_with_Logo_Can__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Canada_Cycle_Flyer_ENG__c == null){
                                masterContact.Bic_Graphic_Canada_Cycle_Flyer_ENG__c = emailContactMap.get(duplicateKey)[index].Bic_Graphic_Canada_Cycle_Flyer_ENG__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Canada_Cycle_Flyer_FRE__c == null){
                                masterContact.Bic_Graphic_Canada_Cycle_Flyer_FRE__c = emailContactMap.get(duplicateKey)[index].Bic_Graphic_Canada_Cycle_Flyer_FRE__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Cycle_Flyer__c == null){
                                masterContact.Bic_Graphic_Cycle_Flyer__c = emailContactMap.get(duplicateKey)[index].Bic_Graphic_Cycle_Flyer__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Cycle_Flyer_with_Logo__c == null){
                                masterContact.Bic_Graphic_Cycle_Flyer_with_Logo__c = emailContactMap.get(duplicateKey)[index].Bic_Graphic_Cycle_Flyer_with_Logo__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Triumph_GV_Calendars_Cat__c == null){
                                masterContact.Bic_Graphic_Triumph_GV_Calendars_Cat__c = emailContactMap.get(duplicateKey)[index].Bic_Graphic_Triumph_GV_Calendars_Cat__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Triumph_GV_Calendars_Canada__c == null){
                                masterContact.Bic_Graphic_Triumph_GV_Calendars_Canada__c = emailContactMap.get(duplicateKey)[index].Bic_Graphic_Triumph_GV_Calendars_Canada__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Catalog__c == null){
                                masterContact.Bic_Graphic_Catalog__c = emailContactMap.get(duplicateKey)[index].Bic_Graphic_Catalog__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Catalog_with_Logo__c == null){
                                masterContact.Bic_Graphic_Catalog_with_Logo__c = emailContactMap.get(duplicateKey)[index].Bic_Graphic_Catalog_with_Logo__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Catalog_with_Logo_Canada__c == null){
                                masterContact.Bic_Graphic_Catalog_with_Logo_Canada__c = emailContactMap.get(duplicateKey)[index].Bic_Graphic_Catalog_with_Logo_Canada__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Canada_Catalog_Eng__c == null){
                                masterContact.Bic_Graphic_Canada_Catalog_Eng__c = emailContactMap.get(duplicateKey)[index].Bic_Graphic_Canada_Catalog_Eng__c;
                            }
                            
                            if(masterContact.Bic_Graphic_Canada_Catalog_FRE__c == null){
                                masterContact.Bic_Graphic_Canada_Catalog_FRE__c = emailContactMap.get(duplicateKey)[index].Bic_Graphic_Canada_Catalog_FRE__c;
                            }
                            
                            if(masterContact.Line_Total__c == null){
                                masterContact.Line_Total__c = emailContactMap.get(duplicateKey)[index].Line_Total__c;
                            }
                            
                            if(masterContact.Master_Merge__c == null){
                                masterContact.Master_Merge__c = emailContactMap.get(duplicateKey)[index].Master_Merge__c;
                            } 
                            
                            if(masterContact.MergePriority__c == null){
                                masterContact.MergePriority__c = emailContactMap.get(duplicateKey)[index].MergePriority__c;
                            }
                            
                            if(masterContact.Mkt__c == null){
                                masterContact.Mkt__c = emailContactMap.get(duplicateKey)[index].Mkt__c;
                            }
                            
                            if(masterContact.Mktg_Address_City__c == null){
                                masterContact.Mktg_Address_City__c = emailContactMap.get(duplicateKey)[index].Mktg_Address_City__c;
                            }
                            
                            if(masterContact.Mktg_Address_Country__c == null){
                                masterContact.Mktg_Address_Country__c = emailContactMap.get(duplicateKey)[index].Mktg_Address_Country__c;
                            }
                            
                            if(masterContact.Mktg_Address_Customer_Verified__c == null){
                                masterContact.Mktg_Address_Customer_Verified__c = emailContactMap.get(duplicateKey)[index].Mktg_Address_Customer_Verified__c;
                            }
                            
                            if(masterContact.Mktg_Address_State_Province__c == null){
                                masterContact.Mktg_Address_State_Province__c = emailContactMap.get(duplicateKey)[index].Mktg_Address_State_Province__c;
                            }
                            
                            if(masterContact.Mktg_Address_Street__c == null){
                                masterContact.Mktg_Address_Street__c = emailContactMap.get(duplicateKey)[index].Mktg_Address_Street__c;
                            }
                            
                            if(masterContact.Mktg_Address_Verification_Date__c == null){
                                masterContact.Mktg_Address_Verification_Date__c = emailContactMap.get(duplicateKey)[index].Mktg_Address_Verification_Date__c;
                            }

                            if(masterContact.Mktg_Address_Zip_Postal_Code__c == null){
                                masterContact.Mktg_Address_Zip_Postal_Code__c = emailContactMap.get(duplicateKey)[index].Mktg_Address_Zip_Postal_Code__c;
                            }
                            
                            if(masterContact.MOB_Opt_Out__c == null){
                                masterContact.MOB_Opt_Out__c = emailContactMap.get(duplicateKey)[index].MOB_Opt_Out__c;
                            }
                            
                            if(masterContact.Motivator_On_Board__c == null){
                                masterContact.Motivator_On_Board__c = emailContactMap.get(duplicateKey)[index].Motivator_On_Board__c;
                            }
                            
                            if(masterContact.New_Product_Information__c == null){
                                masterContact.New_Product_Information__c = emailContactMap.get(duplicateKey)[index].New_Product_Information__c;
                            }
                            
                            if(masterContact.Newsletters__c == null){
                                masterContact.Newsletters__c = emailContactMap.get(duplicateKey)[index].Newsletters__c;
                            }
                            
                            if(masterContact.Norwood__c == null){
                                masterContact.Norwood__c = emailContactMap.get(duplicateKey)[index].Norwood__c;
                            }
                            
                            if(masterContact.Not_Duplicate__c == null){
                                masterContact.Not_Duplicate__c = emailContactMap.get(duplicateKey)[index].Not_Duplicate__c;
                            }
                            
                            if(masterContact.Onboarding_Opt_Out__c == null){
                                masterContact.Onboarding_Opt_Out__c = emailContactMap.get(duplicateKey)[index].Onboarding_Opt_Out__c;
                            } 

                            if(masterContact.Other_Email__c == null){
                                masterContact.Other_Email__c = emailContactMap.get(duplicateKey)[index].Other_Email__c;
                            } 
                            
                            if(masterContact.OtherPhoneID__c == null){
                                masterContact.OtherPhoneID__c = emailContactMap.get(duplicateKey)[index].OtherPhoneID__c;
                            }
                            
                            if(masterContact.Preferred_Channel__c == null){
                                masterContact.Preferred_Channel__c = emailContactMap.get(duplicateKey)[index].Preferred_Channel__c;
                            }
                            
                            if(masterContact.Preferred_Contact__c == null){
                                masterContact.Preferred_Contact__c = emailContactMap.get(duplicateKey)[index].Preferred_Contact__c;
                            }
                            
                            if(masterContact.Preferred_Phone_Number__c == null){
                                masterContact.Preferred_Phone_Number__c = emailContactMap.get(duplicateKey)[index].Preferred_Phone_Number__c;
                            } 

                            if(masterContact.Primary_ID__c == null){
                                masterContact.Primary_ID__c = emailContactMap.get(duplicateKey)[index].Primary_ID__c;
                            }
                            
                            if(masterContact.PrimaryOtherEmailFlag__c == null){
                                masterContact.PrimaryOtherEmailFlag__c = emailContactMap.get(duplicateKey)[index].PrimaryOtherEmailFlag__c;
                            }
                            
                            if(masterContact.Primary_Responsibility_Flag__c == null){
                                masterContact.Primary_Responsibility_Flag__c = emailContactMap.get(duplicateKey)[index].Primary_Responsibility_Flag__c;
                            }
                            
                            if(masterContact.PrimaryEmailFlag__c == null){
                                masterContact.PrimaryEmailFlag__c = emailContactMap.get(duplicateKey)[index].PrimaryEmailFlag__c;
                            }
                            
                            if(masterContact.PrimaryFaxFlag__c == null){
                                masterContact.PrimaryFaxFlag__c = emailContactMap.get(duplicateKey)[index].PrimaryFaxFlag__c;
                            }
                            
                            if(masterContact.PrimaryOtherPhoneFlag__c == null){
                                masterContact.PrimaryOtherPhoneFlag__c = emailContactMap.get(duplicateKey)[index].PrimaryOtherPhoneFlag__c;
                            }
                            
                            if(masterContact.PrimaryPhoneFlag__c == null){
                                masterContact.PrimaryPhoneFlag__c = emailContactMap.get(duplicateKey)[index].PrimaryPhoneFlag__c;
                            }
                            
                            if(masterContact.Product_Knowledge__c == null){
                                masterContact.Product_Knowledge__c = emailContactMap.get(duplicateKey)[index].Product_Knowledge__c;
                            }
                            
                            if(masterContact.PromoStandards_Contact__c == null){
                                masterContact.PromoStandards_Contact__c = emailContactMap.get(duplicateKey)[index].PromoStandards_Contact__c;
                            }
                            
                            if(masterContact.Purchaser__c == null){
                                masterContact.Purchaser__c = emailContactMap.get(duplicateKey)[index].Purchaser__c;
                            }
                            
                            if(masterContact.Random_Samples_Journey__c == null){
                                masterContact.Random_Samples_Journey__c = emailContactMap.get(duplicateKey)[index].Random_Samples_Journey__c;
                            }
                            
                            if(masterContact.Responsibility_Type__c == null){
                                masterContact.Responsibility_Type__c = emailContactMap.get(duplicateKey)[index].Responsibility_Type__c;
                            }
                            
                            if(masterContact.Samples__c == null){
                                masterContact.Samples__c = emailContactMap.get(duplicateKey)[index].Samples__c;
                            }
                            
                            if(masterContact.Secondary_Contact_Type__c == null){
                                masterContact.Secondary_Contact_Type__c = emailContactMap.get(duplicateKey)[index].Secondary_Contact_Type__c;
                            }
                            
                            if(masterContact.Shared_Email__c == null){
                                masterContact.Shared_Email__c = emailContactMap.get(duplicateKey)[index].Shared_Email__c;
                            }
                            
                            if(masterContact.Source__c == null){
                                masterContact.Source__c = emailContactMap.get(duplicateKey)[index].Source__c;
                            }
                            
                            if(masterContact.Source_ID__c == null){
                                masterContact.Source_ID__c = emailContactMap.get(duplicateKey)[index].Source_ID__c;
                            }
                            
                            if(masterContact.Storyboards__c == null){
                                masterContact.Storyboards__c = emailContactMap.get(duplicateKey)[index].Storyboards__c;
                            }
                            
                            if(masterContact.Top_Producer__c == null){
                                masterContact.Top_Producer__c = emailContactMap.get(duplicateKey)[index].Top_Producer__c;
                            }
                            
                            if(masterContact.Verified__c != true){
                                masterContact.Verified__c = emailContactMap.get(duplicateKey)[index].Verified__c;
                            }
                            
                            if(masterContact.Website__c == null){
                                masterContact.Website__c = emailContactMap.get(duplicateKey)[index].Website__c;
                            }
                            
                            if(masterContact.Weekly_USB_Pricing__c == null){
                                masterContact.Weekly_USB_Pricing__c = emailContactMap.get(duplicateKey)[index].Weekly_USB_Pricing__c;
                            }
                            
                            if(masterContact.Title == null){
                                masterContact.Title = emailContactMap.get(duplicateKey)[index].Title;
                            }
                            
                            if(masterContact.MailingStreet == null){
                                masterContact.MailingStreet = emailContactMap.get(duplicateKey)[index].MailingStreet;
                            }
                            
                            if(masterContact.MailingCity == null){
                                masterContact.MailingCity = emailContactMap.get(duplicateKey)[index].MailingCity;
                            }
                            
                            if(masterContact.MailingState == null){
                                masterContact.MailingState = emailContactMap.get(duplicateKey)[index].MailingState;
                            }
                            
                            if(masterContact.MailingCountry == null){
                                masterContact.MailingCountry = emailContactMap.get(duplicateKey)[index].MailingCountry;
                            }
                            
                            if(masterContact.MailingPostalCode == null){
                                masterContact.MailingPostalCode = emailContactMap.get(duplicateKey)[index].MailingPostalCode;
                            }
                           
                            if(mergeMap.containsKey(emailContactMap.get(duplicateKey)[index])){
                                mergeMap.get(masterContact).add(emailContactMap.get(duplicateKey)[index].Id);
                            }else{
                                mergeMap.put(masterContact, new List<Id>{emailContactMap.get(duplicateKey)[index].Id});
                            } 
                        }
                    }
                } else{
                    // // System.debug('===== No Merge Occured ======='); 
                }                
            }
        }
        /*
        *	Description : Merging the Records using Database.Merge (MasterContact,List<Contact>)
        *               : Updating the fields in the master Contact which are null from the Loosing contacts. 
        */
        if(mergeMap != null){
            List<Contact> tempcontactList = new List<Contact>();            
            for(Contact record :  mergeMap.keySet()){
                Database.mergeResult[] mergeResult = Database.merge(record,mergeMap.get(record),false);
                for(Database.mergeResult result : mergeResult){
                    if(result.isSuccess()){ 
                        tempcontactList.add(record); 
                    }else{
                        List<Database.error> er = result.getErrors();
                        for(Database.error err : er){
                           // System.debug('ERROR Occured '+err);
                        }
                    }
                } 
            }
            if(tempcontactList.size() > 1){
                UPDATE tempcontactList;
            }   
        } 
    }
    /*
    *	Description : Updating the isBatchRunning field to false on Contact which were processed in the Batch.
    */
    public void finish(Database.BatchableContext bc){
        List<Contact> updatedContactList = new List<Contact>();
        Contact [] contactList = [Select Id from Contact where isBatchRunning__c = true]; 
        if(!contactList.isEmpty()){
            for(Contact c : contactList){
                c.isBatchRunning__c = false;
                updatedContactList.add(c);
            }
        }
        if(!updatedContactList.isEmpty()){
            Database.DMLOptions dml = new Database.DMLOptions(); 
            dml.DuplicateRuleHeader.AllowSave = true;
            Database.update(updatedContactList, dml);
        }
        // System.debug(':::: Merge Process Finished :::: ');
    }
    /*
    * @description : Send Email if duplicate contacts are found with WebIds.
    * @paramerters : email Address, Subject, Map<duplicateKey,Contact List>
    */
    private static void sendMail(String address, String subject, Map<String,List<Contact>> neglectContactMergeMap) {
        String emailBody = '';
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        for(String dupkey: neglectContactMergeMap.keySet()){
            emailBody += 'Total Duplicate CRM Contacts with email and have web Ids : <strong> ' + neglectContactMergeMap.get(dupkey)[0].Email + ' : </strong>'+neglectContactMergeMap.get(dupkey).size()+'<br><br>';
            emailBody += '<table border="1"><tr><th>Contact Record Id</th><th>Account Id</th><th>Web Id</th></tr>';
            for(Contact contactRecords : neglectContactMergeMap.get(dupkey)){
                emailBody += '<tr><td>' + contactRecords.Id + '</td><td>' + contactRecords.AccountId + '</td><td>' + contactRecords.Web_Id__c + '</td></tr>';
            }
            emailBody += '</table><br><br>';
            emailBody+='<br>';
        }
        mail.setHtmlBody(emailBody);
        if(String.isNotBlank(emailBody)){            
            String[] toAddresses = new String[] {address};
            mail.setToAddresses(toAddresses);
            mail.setSubject(subject);
            Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }else{
            // System.debug('emailbody is null');
        }
    }
}