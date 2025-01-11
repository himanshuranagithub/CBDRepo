@IsTest
public class LeadTimeAutomation_Test {
    
    @isTest static void sendLeadTimeAutomationEmailsTest() {
        Account acc = new Account();
        acc.Name = 'test';
        acc.Customer_Account_Number__c = '33381';
        insert acc;
        Contact con = new Contact();
        con.LastName = 'nkumar';
        con.Email= 'nk@kumar.invali.test';
        insert con;
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        // Create a test EBS_Order__c record
        Ebs_Order__c ebsOrder = new Ebs_Order__c();
        ebsOrder.Customer_Account_Number__c = acc.Customer_Account_Number__c;
        ebsOrder.Acc_PO_Contact_To_Email__c = 'ni@kr.com.invalid';
        ebsOrder.PO_Contact__c = con.id;
        ebsOrder.Template_Type__c = 'Koozie Group';
        ebsOrder.Lead_Time_Template__c = 'Koozie: Lead Time Automation';
        insert ebsOrder;
        EBS_Order_Line__c oli = new EBS_Order_Line__c();
        oli.Promise_Date__c = system.today() + 10;
        oli.Request_Ship_Date__c = system.today();
        oli.Order__c = ebsorder.id;
        insert oli;
        ebsOrder.Order_Header_Status__c = 'BOOKED';
        update ebsOrder;
        // Create a Map of Id and Ebs_Order__c record
        List<Id> newEBSorderIdList = new List<Id>();
		newEBSorderIdList.add(ebsOrder.Id);
        LeadTimeAutomation.sendLeadTimeAutomationEmails(newEBSorderIdList);
    }
}