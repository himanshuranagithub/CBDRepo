/**
 * @description       : 
 * @author            : Ritesh Kumar
 * @group             : 
 * @last modified on  : 01-31-2024
 * @last modified by  : Ritesh Kumar
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   01-31-2024   Ritesh Kumar   Initial Version
**/

@IsTest
public with sharing class thinkAutomationCaseLookupsTest {

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
        Account accountRecord =  TestData.createAccount(FALSE);
        accountRecord.Customer_Account_Number__c = '159753215';
        Insert accountRecord;

        Test.setMock(HttpCalloutMock.class, new RestMock());
        Contact contactRecord = TestData.createContact(FALSE,accountRecord.Id);
       contactRecord.email = 'FirstName@test.com';
        Insert contactRecord;

        EBS_Order__c orderRecord = TestData.createEBSOrder(FALSE);
        orderRecord.PO_Contact_Email__c = 'FirstName@test.com.full';
        orderRecord.Customer_Account_Number__c = '159753215';
        orderRecord.EBS_Order_Number__c = '363636565';
        Insert orderRecord;

        EBS_Order_Line__c orderLineRecord = TestData.createEBSOrderLine(false);
        orderLineRecord.Order__c = orderRecord.Id;
        Insert orderLineRecord;
    }

    @IsTest
    public static void testThinkAutomation() {
        Test.setMock(HttpCalloutMock.class, new RestMock());
        Case css = new Case();
        css.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Case').getRecordTypeId();
        css.EBS_Account_Number__c ='159753215';
        css.Status = 'New';
        css.Origin = 'ASI Rating';
        css.SuppliedEmail = 'FirstName@test.com';
        Css.EBS_Order_ID__c = [SELECT Id FROM EBS_Order__c LIMIT 1].Id;
        Insert css;
        
        Test.startTest();
        Set<Id> csid = new Set<Id>();
        csid.add(css.Id);
        thinkAutomationCaseLookups.taCaseLookups( csid, 'Insert', 'Case');
        thinkAutomationCaseLookups.taCaseTeamLookups( csid);
        Test.stopTest();
    }
}