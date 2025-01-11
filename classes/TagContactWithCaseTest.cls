/**
 * @description       : 
 * @author            : ritesh.kumar@kooziegroup.com
 * @group             : 
 * @last modified on  : 09-24-2024
 * @last modified by  : ritesh.kumar@kooziegroup.com
**/
@IsTest
public with sharing class TagContactWithCaseTest {

    private class RestMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HTTPResponse res = new HTTPResponse();
            res.setHeader('Content-Type', 'text/json'); 
            res.setBody('{"EventResponse":{"EventBusinessID":"rob.meier@kooziegroup.com.test", "EventStatus": "SUCCESS", "EventStatusMessage": "Successfully Completed", "CustomerData": { "SFId": "0035300000AgKZNAA3", "web_Id": "5c9e20578513d813ed6e5a43", "emailId": "rob.meier@kooziegroup.com.test" }}}');
            res.setStatusCode(200);
            return res;
        }
    }
    
    @TestSetup
    public static void makeData(){
        
        TestDataFactory.loadAppSetting();
        Account accountRecord = TestDataFactory.createAccount('Test Account', '1234501', 'Customers', TRUE);
        Account accountRecord1 = TestDataFactory.createAccount('Test Domain', '12345025', 'Customers', false);
        accountRecord1.Account_Domain__c = 'testdomain.com.full';
        Insert accountRecord1;
        
        Contact contactRecord1 = TestDataFactory.createContact('Test', 'Contact',accountRecord.Id , 'CRM Contact', FALSE);
        contactRecord1.Contact_Status__c = 'Inactive';
        contactRecord1.email = 'test@test1.com.full';
        Insert contactRecord1;

        Contact contactRecord2 = TestDataFactory.createContact('Test', 'Contact',accountRecord.Id , 'CRM Contact', FALSE);
        contactRecord2.Contact_Status__c = 'Active';
        contactRecord2.email = 'test@test2.com.full';
        Test.setMock(HttpCalloutMock.class, new RestMock());
        Insert contactRecord2;
    }

    @IsTest
    static void testCase_A() {
        // Email and Account both are present in Salesforce.
        Case record  = new Case();
        record.Subject = 'A : Test case with Email and Account';
        record.Case_Reason_Type__c = 'Email'; 
        record.Origin = 'Phone'; 
        record.Status = 'New'; 
        record.SuppliedEmail = 'test@test1.com.full'; 
        record.EBS_Account_Number__c = '1234501'; 
        
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new RestMock());
            insert record;
            verifyLogic(record,'test@test1.com.full', 'Test Unit : testCase_B :: Email and Account both are present in Salesforce.');
        Test.stopTest();
    }

    @IsTest
    static void testCase_B() {
        // Account is present in salesfroce, however contact is new.
        Case record  = new Case();
        record.Subject = 'B : Test case with Email and Account';
        record.Case_Reason_Type__c = 'Email'; 
        record.Origin = 'Phone'; 
        record.Status = 'New'; 
        record.SuppliedEmail = 'test12@test.com.full'; 
        record.EBS_Account_Number__c = '1234501'; 
        
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new RestMock());
            insert record;
            verifyLogic(record,'test12@test.com.full', 'Test Unit : testCase_B :: Account is present in salesfroce, however contact is new'); 
        Test.stopTest();
    }

    @IsTest
    static void testCase_C() {
        // Contact is Present in Salesfroce howver account is blank at case level.
        Case record  = new Case();
        record.Subject = 'B : Test case with Email and Account';
        record.Case_Reason_Type__c = 'Email'; 
        record.Origin = 'Phone'; 
        record.Status = 'New'; 
        record.SuppliedEmail = 'test@test2.com.full'; 
        
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new RestMock());
            insert record;
            verifyLogic(record,'test@test2.com.full', 'Test Unit : testCase_C :: Contact is Present in Salesfroce howver account is blank at case level.'); 
        Test.stopTest();
    }

    @IsTest
    static void testCase_D() {
        // New Contact with Blank Account Number : Orphan Account
        Case record  = new Case();
        record.Subject = 'B : Test case with Email and Account';
        record.Case_Reason_Type__c = 'Email'; 
        record.Origin = 'Phone'; 
        record.Status = 'New'; 
        record.SuppliedEmail = 'test12@test1.com.full';
        
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new RestMock());
            insert record;
            verifyLogic(record,'test12@test1.com.full', 'Test Unit : testCase_D :: ORPHAN_ACOUNT');
        Test.stopTest();
    }

    @IsTest
    static void testCase_E() {
        // New Contact with Blank Account Number : Koozie Account
        Case record  = new Case();
        record.Subject = 'B : Test case with Email and Account';
        record.Case_Reason_Type__c = 'Email'; 
        record.Origin = 'Phone'; 
        record.Status = 'New'; 
        record.SuppliedEmail = 'test@kooziegroup.com.full'; 
        
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new RestMock());
            insert record;
            verifyLogic(record,'test@kooziegroup.com.full', 'Test Unit : testCase_E :: KOOZIE_ACOUNT');
        Test.stopTest();
    }
    
     @IsTest
    static void testCase_F() {
        // New Contact with Blank Account Number : Domain
        Case record  = new Case();
        record.Subject = 'B : Test case with Email and Account';
        record.Case_Reason_Type__c = 'Email'; 
        record.Origin = 'Phone'; 
        record.Status = 'New'; 
        record.SuppliedEmail = 'test@testdomain.com.full'; 
        
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new RestMock());
            insert record;
        	verifyLogic(record,'test@testdomain.com.full', 'Test Unit : testCase_F :: Domain Logic');
        

        Test.stopTest();
    }
    
    static void verifyLogic(Case record, String email, String message){
        
        case afterInsert = [SELECT Id, ContactId, AccountId FROM Case WHERE Id =: record.Id];
            Contact  contactRecord = [SELECT Id, AccountId, Email FROM Contact WHERE Email =: email LIMIT 1];
            String actualContact = afterInsert.ContactId;
            String expectedContact = contactRecord.Id;
            String actualAccount = afterInsert.AccountId;
            String expectedAccount = contactRecord.AccountId;
            System.assertEquals(actualContact,expectedContact,message);
            System.assertEquals(actualAccount,expectedAccount,message); 
        
    }
}