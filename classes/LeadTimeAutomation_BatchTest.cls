@isTest
public with sharing class LeadTimeAutomation_BatchTest {
    private class RestMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            String fullJson = 'Response';

            HTTPResponse res = new HTTPResponse();
            res.setHeader('Content-Type', 'text/json');
            res.setBody(fullJson);
            res.setStatusCode(200);
            return res;
        }
    }
    @testSetup
    public static void testData(){
        List<EBS_Order__c> ebsList = new List<EBS_Order__c>();
        Id accRecTypId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customers').getRecordTypeId();
        Id conRecTypId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('CRM Contact').getRecordTypeId();
		SwitchTrigger__c switchTrigger = new SwitchTrigger__c(Name = 'EmailLinkTrigger', Deactivate__c = false); // Provide appropriate data
        insert switchTrigger;
        Account acc= new Account();
        acc.Name = 'Test Account';
        acc.Acc_PO_Contact_Email__c = 'Test@testing.com';
        acc.Customer_Account_Number__c = '123456';
        acc.Customer_PO_Number__c = '12345';
        acc.RecordTypeId = accRecTypId;
        insert acc;

        Contact con = new Contact();
        con.FirstName = 'Test';
        con.LastName = 'Contact';
        con.AccountId = acc.Id;
        con.Email = 'Test@testing.com';
        con.RecordTypeId = conRecTypId;
        con.Acc_PO_Contact__c = True;
        insert con;
        
		Test.startTest(); 
        EBS_Order__c ebsOrder = new EBS_Order__c();
        ebsOrder.Account_Name__c = acc.Id; 
        ebsOrder.PO_Contact_Email__c = 'Test@testing.com'; //.invalid
        ebsOrder.Customer_Account_Number__c = '123456';
        ebsOrder.Template_Type__c = 'Koozie Group';
        ebsOrder.PO_Contact__c = con.Id;
        ebsOrder.EBS_Order_Number__c = '1234';
        ebsOrder.Send_Lead_Time_Notification__c = true;
        ebsOrder.Acc_PO_Contact_To_Email__c = 'nik@abctestinvalid.com, nik2@abctestinvalid2.com';
        ebsOrder.Lead_Time_Template__c = 'Koozie: Lead Time Automation';
        ebsOrder.PO_Contact__c = con.Id;
        ebsList.add(ebsOrder); 
        Insert ebsList;
        
        LeadTimeAutomation_Scheduler sh1 = new LeadTimeAutomation_Scheduler();      
         String sch = '0 0 15 * * ?';
        system.schedule('Test check', sch, sh1);

        Test.setMock(HttpCalloutMock.class, new RestMock());
        Test.stopTest();
    }
	
    @isTest
    public static void populateAccPoContactCcEmailValuesTest() {

        Test.startTest(); 
        LeadTimeAutomation_Batch bt = new LeadTimeAutomation_Batch();
        LeadTimeAutomation_Scheduler ls = new LeadTimeAutomation_Scheduler();
        String cronexp = '0 30 0 ? * * *';
        //String job = System.schedule('test schedule', cronexp, ls);
        DataBase.executeBatch(bt,1);
        Test.stopTest();
    }
}