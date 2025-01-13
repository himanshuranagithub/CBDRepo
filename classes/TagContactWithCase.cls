/**
 * @description       : 
 * @author            : ritesh.kumar@kooziegroup.com
 * @group             : 
 * @last modified on  : 09-24-2024
 * @last modified by  : ritesh.kumar@kooziegroup.com
**/
public with sharing class TagContactWithCase extends TriggerHandler {

    private List<Case> newRecords;
    private final static String CLARIFICATIONS = 'CLARIFICATIONS';
    private final static String CLARIFICATIONS_RT = 'Clarification';
    private final static String SALES_SERVICE = 'SALES_SERVICE';
    private final static String KOOZIE_ACOUNT_ID = System.Label.Koozie_Group_Account_Id;
    private final static String ORPHAN_ACOUNT_ID = System.Label.Orphan_Account_Id;
    private final static String KOOZIE_DOMAIN = 'kooziegroup.com';
    private static final Trigger_Settings__mdt triggerSetting = Trigger_Settings__mdt.getInstance('Case');
    
    enum CASE_RECORDTYPE{
        CLARIFICATIONS,
        OTHER
    }

    public TagContactWithCase(String className){
        this.newRecords = (List<Case>) Trigger.new;
    }

    public static String getMapKey(Set<String> keys, String email){
        for(String key : keys){
            if(key.contains(email)){
                return key;    
            }
        }
        return null; 
    }
    
    public static Contact_Roles__c createContactRole(String contactId, String accountId, TagContactWithCase.CASE_RECORDTYPE recordType){

        Contact_Roles__c contactRoleRecord = new Contact_Roles__c();
        contactRoleRecord.Contact__c = contactId;
        contactRoleRecord.Account__c = accountId; 
        if(TagContactWithCase.CASE_RECORDTYPE.CLARIFICATIONS == recordType){
            contactRoleRecord.Contact_Role_Name__c = CLARIFICATIONS;
        }else{
            contactRoleRecord.Contact_Role_Name__c = SALES_SERVICE;
        }
        return contactRoleRecord;
    }

    public static Map<String,Contact_Roles__c> checkContactRole(Set<String> contactIds){

        Map<String,Contact_Roles__c> contactRoleRecord = new Map<String,Contact_Roles__c>();

        for(Contact_Roles__c record : [
            SELECT 
                Contact__c, Contact__r.AccountId, Id,Contact_Role_Name__c 
            FROM
                Contact_Roles__c
            WHERE 
                Contact__c =: contactIds AND 
                (Contact_Role_Name__c = : CLARIFICATIONS OR Contact_Role_Name__c = :SALES_SERVICE) 
            ORDER BY 
                CreatedDate 

        ]){
            contactRoleRecord.put(record.Contact__c+ record.Contact_Role_Name__c,record);
        }

        return contactRoleRecord;
    }

    public static Contact createContact(String email, String accountId, String accountNumber){
       //System.debug(LoggingLevel.INFO,' ======= Create Contact  -> Input Email : '+ email + ', Input Account ID : '+accountId+', Input Account Number'+ accountNumber);
        Contact contactRecord = new Contact();
        contactRecord.LastName = 'Customer';
        contactRecord.FirstName = 'Valued';
        contactRecord.Email = email;
        contactRecord.Contact_Status__c = 'Active'; 
        contactRecord.AccountId = accountId;
        contactRecord.RecordTypeId = KoozieUtility.getRecordTypeId('Contact', 'CRM Contact');
        contactRecord.Source__c = 'TagContactWithCase'; 
        return contactRecord;
    }

    public static Map<String,Account> searchAccount(Set<String> accountNumbers ){
      //System.debug(LoggingLevel.INFO,' ======= Search Accunt -> Input Account Numbers : '+accountNumbers );
        Map<String,Account> accountRecords = new Map<String,Account>();
            
        for( Account record : [
            SELECT 
                Id,  Customer_Account_Number__c, Account_Domain__c, Account_Email_Domain__c
            FROM Account 
            WHERE 
                Customer_Account_Number__c = :accountNumbers
                Order By CreatedDate DESC
        ]){
            accountRecords.put(record.Customer_Account_Number__c,record);
        }
        
      //System.debug(LoggingLevel.INFO,' ======= Search Contact -> Output Accounts : '+ accountRecords);
        return accountRecords;
    }

    public static Map<String, Account> searchAccountByDomain(Set<String> domians ){
      //System.debug(LoggingLevel.INFO,' ======= Search Accunt -> Input Domians : '+domians );
        Map<String, Account> accounts = new Map<String, Account>();
        for( Account record : [SELECT Id, Account_Domain__c, Customer_Account_Number__c FROM Account WHERE Account_Domain__c IN :domians]){
            accounts.put(record.Account_Domain__c, record);
        }
      //System.debug(LoggingLevel.INFO,' ======= Search Contact -> Output Accounts : '+accounts);
        return accounts;
    }

    public static string getAccountId(Map<String, Account> domains, String email){

        String currentDomain = email.split('@')[1];
        if(domains != null){

            if(domains.containsKey(currentDomain)){
                return domains.get(currentDomain).Id;
            }else{
                return currentDomain == KOOZIE_DOMAIN ? KOOZIE_ACOUNT_ID : ORPHAN_ACOUNT_ID;
            }
        }else{
            return currentDomain == KOOZIE_DOMAIN ? KOOZIE_ACOUNT_ID : ORPHAN_ACOUNT_ID;
        }
    }

    public static Map<String, Contact> searchContact(Set<String> emails, Set<String> accountNumbers){
      //System.debug(LoggingLevel.INFO,' ======= Search Contact -> Input Emails : '+emails + ', Input Account Numbers : '+accountNumbers );
        Map<String, Contact> contactRecords = new Map<String, Contact>();
        for(Contact record : [
            SELECT 
                Id, Email, Account.Customer_Account_Number__c, AccountId, Account.Account_Domain__c, Account.Account_Email_Domain__c, Contact_Status__c
            FROM Contact 
            WHERE 
                RecordType.Name = 'CRM Contact' AND
                (
                    Email =:emails OR Account.Customer_Account_Number__c =:accountNumbers
                )
                Order By CreatedDate DESC
        ]){
            String accountNumber =  String.isNotBlank(record.Account.Customer_Account_Number__c) ? record.Account.Customer_Account_Number__c :''; 
            contactRecords.put(record.Email +accountNumber, record);
        }
        
      //System.debug(LoggingLevel.INFO,' ======= Search Contact -> Output Contacts : '+contactRecords  );
        return contactRecords;
    }
	
    public static CreateContactWrapper insertContact(List<Contact> contactList, List<case> caseList, Map<String,Account> accounts_DB ){
       //System.debug(LoggingLevel.INFO,' ======= Insert Contact ->  Contact List : '+ contactList);
       //System.debug(LoggingLevel.INFO,' ======= Insert Contact ->  Case List : '+ caseList);
       //System.debug(LoggingLevel.INFO,' ======= Insert Contact ->  Accounts DB : '+ accounts_DB);
        CreateContactWrapper insertedContact = new CreateContactWrapper();
        List<Contact_Roles__c> insertContactoles = new List<Contact_Roles__c>();
        if(contactList.size() > 0){
            Insert contactList;

            for(Contact record : contactList){
                insertedContact.contactMap.put(record.Email+record.AccountId, record);
            }

            for(Case record : caseList){
                String  mapKey = '';
                if(record.EBS_Account_Number__c != null){
                    
                    if(accounts_DB.containsKey(record.EBS_Account_Number__c))
                        mapKey = record.SuppliedEmail + accounts_DB.get(record.EBS_Account_Number__c).Id;
                    if(insertedContact.contactMap.containsKey(mapKey)){
                        if(record.RecordTypeId != null){
                            insertContactoles.add(
                                createContactRole(
                                    insertedContact.contactMap.get(mapKey).Id, 
                                    insertedContact.contactMap.get(mapKey).AccountId,
                                    KoozieUtility.getRecordTypeName('Case', record.RecordTypeId) == CLARIFICATIONS_RT ? TagContactWithCase.CASE_RECORDTYPE.CLARIFICATIONS : TagContactWithCase.CASE_RECORDTYPE.OTHER
                                )
                            );
                        }
                    }
                } else {
                    mapKey = getMapKey( insertedContact.contactMap.keySet(), record.SuppliedEmail);
                    insertContactoles.add(
                        createContactRole(
                            insertedContact.contactMap.get(mapKey).Id, 
                            insertedContact.contactMap.get(mapKey).AccountId,
                            KoozieUtility.getRecordTypeName('Case', record.RecordTypeId) == CLARIFICATIONS_RT ? TagContactWithCase.CASE_RECORDTYPE.CLARIFICATIONS : TagContactWithCase.CASE_RECORDTYPE.OTHER
                        )
                    );
                }
            }

            if(insertContactoles.size() > 0){
                Insert insertContactoles;
            }

        }
        return insertedContact; 
    }

    public static void insertContactRole(Set<String> contactIds, List<case> caseList){ 
        List<Contact_Roles__c> insertContactoles = new List<Contact_Roles__c>(); 
        Map<String,Contact_Roles__c> contactRole_DB = checkContactRole(contactIds);
        if(contactIds.size() > 0){

            for(Case record : caseList){
                if(record.RecordTypeId != null){
                    String caseRecordType = KoozieUtility.getRecordTypeName('Case', record.RecordTypeId) == CLARIFICATIONS_RT ? CLARIFICATIONS : SALES_SERVICE;
                    if(record.ContactId != null){
                        if(!contactRole_DB.containsKey(record.ContactId+caseRecordType)){
                            insertContactoles.add(
                                createContactRole(
                                    record.ContactId, 
                                    record.AccountId,
                                    KoozieUtility.getRecordTypeName('Case', record.RecordTypeId) == CLARIFICATIONS_RT ? TagContactWithCase.CASE_RECORDTYPE.CLARIFICATIONS : TagContactWithCase.CASE_RECORDTYPE.OTHER
                                )
                            );
                        }
                    }
                }
            }

            if(insertContactoles.size() > 0){
                Insert insertContactoles;
            }
        }
    }

    public static void tagContactWithCase(List<Case> caseList){
       //System.debug(LoggingLevel.INFO,' ======= Tag Contact With case  -> Input Nummber of Cases : '+caseList.size());
        CaseFilter caseFilter = new CaseFilter();
        List<Contact> updateContact = new List<Contact>();
        List<Case> updateCases = new List<Case>();
        List<Contact> insertContact = new List<Contact>();
        Set<String> contactIDs = new Set<String>(); 

        for(case record :caseList ){
            if(record.SuppliedEmail != null){
                caseFilter.emailID.add(record.SuppliedEmail);
                caseFilter.domains.add(record.SuppliedEmail.split('@')[1]);
            }

            if(record.EBS_Account_Number__c != null ){
                caseFilter.accountNumber.add(record.EBS_Account_Number__c);
            }
        }

        Map<String, Contact> contacts_DB = searchContact(caseFilter.emailID, caseFilter.accountNumber);
        Map<String,Account> accounts_DB = searchAccount(caseFilter.accountNumber);
        Map<String,Account> domain_DB = searchAccountByDomain(caseFilter.domains);

       //System.debug(LoggingLevel.INFO,' ======= Salesforce -> contacts_DB : '+contacts_DB.keySet() );
       //System.debug(LoggingLevel.INFO,' ======= Salesforce -> accounts_DB : '+accounts_DB );
       //System.debug(LoggingLevel.INFO,' ======= Salesforce -> domain_DB : '+domain_DB );

        for(case record :caseList ){

            if(record.SuppliedEmail != null && record.EBS_Account_Number__c != null){
               //System.debug(LoggingLevel.INFO,'==== START Email and Account is present ===');
                String contactKey  = record.SuppliedEmail + record.EBS_Account_Number__c;
               //System.debug('==== Contact Search Key ==='+contactKey);

                if(contacts_DB.containsKey(contactKey)){
                    record.contactId = contacts_DB.get(contactKey).Id;
                    record.AccountId = contacts_DB.get(contactKey).AccountId;
                    if(contacts_DB.get(contactKey).Contact_Status__c  != 'Active'){
                        updateContact.add(new Contact(Id = contacts_DB.get(contactKey).Id, Contact_Status__c = 'Active',Source__c='TagContactWithCase'));
                    }
                    contactIDs.add(contacts_DB.get(contactKey).Id);

                }else{
                    String accountId = accounts_DB.containsKey(record.EBS_Account_Number__c) ? accounts_DB.get(record.EBS_Account_Number__c).Id : null ;
                    record.AccountId = accountId;
                    //updateCases.add(new Case(Id = record.Id, AccountId = accountId));
                    insertContact.add(createContact(record.SuppliedEmail, accountId, record.EBS_Account_Number__c));
                }
 
               //System.debug(LoggingLevel.INFO,'\t======= Salesforce -> Insert Contact Size : '+insertContact.size());
               //System.debug(LoggingLevel.INFO,'\t======= Salesforce -> Contact Id\'s Size : '+contactIDs.size());
               //System.debug(LoggingLevel.INFO,'\t======= Salesforce -> Update Contact Size : '+updateContact.size());
               //System.debug(LoggingLevel.INFO,'\t======= END Email and Account is present ===');

            }else if(record.SuppliedEmail != null && record.EBS_Account_Number__c == null){
               //System.debug(LoggingLevel.INFO,'==== START Email is present Account is Blank ===');
                
                String contactKey  = getMapKey(contacts_DB.keySet(),record.SuppliedEmail);
               //System.debug('==== Contact Search Key ==='+contactKey);
                if(contacts_DB.containsKey(contactKey)){
                   //System.debug('==== Contact AccountId ==='+contacts_DB.get(contactKey).AccountId);
                   //System.debug('==== Contact contactId ==='+contacts_DB.get(contactKey).Id);
                    record.contactId = contacts_DB.get(contactKey).Id;
                    record.AccountId = contacts_DB.get(contactKey).AccountId;
                    if(contacts_DB.get(contactKey).Contact_Status__c  != 'Active'){
                        updateContact.add(new Contact(Id = contacts_DB.get(contactKey).Id, Contact_Status__c = 'Active',Source__c='TagContactWithCase'));
                    }
                    contactIDs.add(contacts_DB.get(contactKey).Id);

                }else{
                    String accountId = getAccountId(domain_DB, record.SuppliedEmail);
                    record.AccountId = accountId;
                   //System.debug('==== Contact AccountId  else ==='+record.AccountId);
                    //updateCases.add(new Case(Id = record.Id, AccountId = accountId));
                    insertContact.add(createContact(record.SuppliedEmail, record.AccountId,record.EBS_Account_Number__c));
                } 
               //System.debug(LoggingLevel.INFO,'\t======= Salesforce -> Insert Contact Size : '+insertContact.size());
               //System.debug(LoggingLevel.INFO,'\t======= Salesforce -> Contact Id\'s Size : '+contactIDs.size());
               //System.debug(LoggingLevel.INFO,'\t======= Salesforce -> Update Contact Size : '+updateContact.size());
               //System.debug(LoggingLevel.INFO,'==== END Email is present Account is Blank ===');
            }else{
               //System.debug(LoggingLevel.INFO,'============================= DEFAULT =============================' );

            }
        }

        CreateContactWrapper insertedContact  = new  CreateContactWrapper();
          // Insert Contact  

        if(insertContact.size() > 0){
            insertedContact = insertContact(insertContact,caseList,accounts_DB);
           //System.debug(LoggingLevel.INFO,'======= Inserted Contact -> '+insertedContact.contactMap.values().size());
           //System.debug(LoggingLevel.INFO,'======= Inserted Contact Key  -> '+insertedContact.contactRoleMap.values().size());
        }

        for(case record :caseList){
            if(record.ContactId == null && record.SuppliedEmail != null && record.EBS_Account_Number__c != null){
                String mapKey = record.SuppliedEmail+accounts_DB.get(record.EBS_Account_Number__c).Id;
                if(insertedContact.contactMap.containsKey(mapKey) != null){ 
                    record.contactId = insertedContact.contactMap.get(mapKey).Id;
                    record.accountId = insertedContact.contactMap.get(mapKey).AccountId;

                }
            }else if(record.ContactId == null && record.SuppliedEmail != null && record.EBS_Account_Number__c == null){
                String mapKey = record.SuppliedEmail+getAccountId(domain_DB,record.SuppliedEmail);
                if(insertedContact.contactMap.containsKey(mapKey) != null){ 
                    record.contactId = insertedContact.contactMap.get(mapKey).Id;
                    record.accountId = insertedContact.contactMap.get(mapKey).AccountId;

                }
            }
        }  

        if(contactIDs.size() > 0){
            insertContactRole(contactIDs,caseList);
        }

        if(updateCases.size() > 0){
            Update updateCases;
        }
    }

    public override void beforeInsert() {
       //System.debug(LoggingLevel.INFO,'===== START afterInsert ====='+triggerSetting.Is_Active__c);
         if(triggerSetting.Is_Active__c == FALSE){
            return;
        }
        tagContactWithCase(newRecords);        
       //System.debug(LoggingLevel.INFO,'===== END afterInsert =====');
    } 

    public class CreateContactWrapper{
        public Map<String, Contact> contactMap;
        public Map<String, Contact_Roles__c> contactRoleMap;

        public CreateContactWrapper(){
            contactMap = new Map<String, Contact>();
            contactRoleMap = new Map<String, Contact_Roles__c>();
        }
    }

    public class CaseFilter{
        public Set<String> emailID ;
        public Set<String> accountNumber;
        public Set<String> domains;

        public caseFilter(){
            emailID = new Set<String>();
            accountNumber = new Set<String>();
            domains = new Set<String>();
        }
    }

}