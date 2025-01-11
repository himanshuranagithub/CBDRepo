/*
* @description       : Test Class for emailMessageTriggerHandler
* @author            :  
* @group             : 
* @last modified on  : 28-02-2024
* @last modified by  : Anubhav Saxena
*/
@isTest
public class emailMessageTriggerHandler_TestClass {
    // public static String caseNumber = '';
    @testSetup
    public static void caseData() {
        List<Case> listInsertCase = new List<Case>();
        SwitchTrigger__c switchTrigger = new SwitchTrigger__c(Name = 'EmailLinkTrigger', Deactivate__c = false); // Provide appropriate data
        insert switchTrigger;
        Case cs = new Case(Subject = 'Parent Test Case', Status = 'Merged', RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Clarification').getRecordTypeId()); 
        listInsertCase.add(cs);
        Case testcs = new Case(Subject = 'Test Case Scenario', Status = 'Merged', RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Case').getRecordTypeId()); 
        listInsertCase.add(testcs);
        Case testcs1 = new Case(Subject = 'Test Case Scenario 2', Status = 'New', RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Case').getRecordTypeId()); 
        listInsertCase.add(testcs1);
        Case testcs2 = new Case(Subject = 'Test Case Scenario 3', Status = 'New', RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Clarification').getRecordTypeId()); 
        listInsertCase.add(testcs2);
        insert  listInsertCase;
    }
    @isTest
    private static void testEmailMessageTriggerHandler1() {
        List<Case> parentCaseList = [Select Id,CaseNumber,Merged_Parent_Case__c,Status from Case where Subject = 'Parent Test Case' LIMIT 1];
        parentCaseList.get(0).Status = 'Merged';
        parentCaseList.get(0).Merged_Parent_Case__c=parentCaseList.get(0).CaseNumber;
        UPDATE parentCaseList;

        Test.startTest();
        EmailMessage emailMessage1 = new EmailMessage(); 
        emailMessage1.status = '3'; // email was sent 
        emailMessage1.fromName = 'Test Name'; // from name 
        emailMessage1.subject = 'This is the Subject!'; // email subject 
        emailMessage1.htmlBody = '<html><body><b>Hello</b></body></html>'; // email body 
        emailMessage1.ParentId = parentCaseList.get(0).id;
        emailMessage1.CreatedDate = System.now();
        insert emailMessage1; 
		
        Test.stopTest();
    }
    @isTest
    private static void testEmailMessageTriggerHandler2(){
        List<Case> parentCaseList = [Select Id,CaseNumber,Merged_Parent_Case__c,Status from Case where Subject = 'Test Case Scenario' LIMIT 1];
        parentCaseList.get(0).Status = 'Closed';
        parentCaseList.get(0).Merged_Parent_Case__c=parentCaseList.get(0).CaseNumber;
        parentCaseList.get(0).Case_Reason_Type__c = 'Chat';
        parentCaseList.get(0).Reason_Closed__c = 'Closing for Test Class';
        update parentCaseList;
        Test.startTest();
        EmailMessage emailMessage1 = new EmailMessage(); 
        emailMessage1.status = '2'; // email was sent 
        emailMessage1.fromName = 'Test Name'; // from name 
        emailMessage1.subject = 'This is the Subject!'; // email subject 
        emailMessage1.htmlBody = '<html><body><b>Hello</b></body></html>'; // email body 
        emailMessage1.ParentId = parentCaseList.get(0).id;
        emailMessage1.CreatedDate = System.now();
        insert emailMessage1; 
        Test.stopTest();
    } 
    @isTest
    private static void testEmailMessageTriggerHandler3(){
        List<Case> parentCaseList = [Select Id,CaseNumber,Merged_Parent_Case__c,Status from Case where Subject = 'Test Case Scenario 2' LIMIT 1];
        parentCaseList.get(0).Merged_Parent_Case__c=parentCaseList.get(0).CaseNumber;
        update parentCaseList;
        Test.startTest();
        EmailMessage emailMessage1 = new EmailMessage(); 
        emailMessage1.status = '4'; // email was sent 
        emailMessage1.fromName = 'Test Name'; // from name 
        emailMessage1.subject = 'This is the Subject!'; // email subject 
        emailMessage1.htmlBody = '<html><body><b>Hello</b></body></html>'; // email body 
        emailMessage1.ParentId = parentCaseList.get(0).id;
        emailMessage1.CreatedDate = System.now();
        insert emailMessage1; 
        Test.stopTest();
    }
    @isTest
    private static void testEmailMessageTriggerHandler4(){
        List<Case> parentCaseList = [Select Id,CaseNumber,Merged_Parent_Case__c,Status from Case where Subject = 'Test Case Scenario 3' LIMIT 1];
        Test.startTest();
        EmailMessage emailMessage1 = new EmailMessage(); 
        emailMessage1.status = '4'; // email was sent 
        emailMessage1.fromName = 'Test Name'; // from name 
        emailMessage1.subject = 'This is the Subject!'; // email subject 
        emailMessage1.htmlBody = '<html><body><b>Hello</b></body></html>'; // email body 
        emailMessage1.ParentId = parentCaseList.get(0).id;
        emailMessage1.CreatedDate = System.now();
        insert emailMessage1; 
        Test.stopTest();
    } 
}