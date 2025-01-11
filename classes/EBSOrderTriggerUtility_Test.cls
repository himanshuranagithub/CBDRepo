@isTest
public with sharing class EBSOrderTriggerUtility_Test {

    private static String accountCustomerRecordTypeId = KoozieUtility.getRecordTypeId('Account','Customers');
    private static String contactCRMRecordTypeId = KoozieUtility.getRecordTypeId('Contact', 'CRM Contact');

    @TestSetup
    private static void inserTestData(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Account accountTestRecord = TestData.createAccount(false);
        accountTestRecord.RecordTypeId = accountCustomerRecordTypeId;
        INSERT accountTestRecord;

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Contact contactTestRecord = TestData.createContact(false, accountTestRecord.Id);
        contactTestRecord.RecordTypeId = contactCRMRecordTypeId;
        INSERT contactTestRecord;
    }

    @isTest
    private static void insertEBSOrderRecordScenario00(){
        List<Account> accTestRecord = [SELECT Id FROM Account LIMIT 1];

        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        EBS_Order__c ebsOrderTestRecord = new EBS_Order__c(Account_Name__c = accTestRecord.get(0).Id,Order_Confirmation_Email__c='testOrderKoozie@test.com.full');
        INSERT ebsOrderTestRecord;
        List<EBS_Order__c> ebsOrderRecordList = getEBSOrderRecord(ebsOrderTestRecord.Id);
        system.assert(ebsOrderRecordList.get(0).Order_Confirm_Contact__c!=null , 'Order contact is not populated');

        Test.stopTest();
    }

    @isTest
    private static void insertEBSOrderRecordScenario01(){
        List<Account> accTestRecord = [SELECT Id FROM Account LIMIT 1];

        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        EBS_Order__c ebsOrderTestRecord = new EBS_Order__c(Account_Name__c = accTestRecord.get(0).Id,Shipping_Notification_Email__c='testShippingKoozie@test.com.full');
        INSERT ebsOrderTestRecord;
        List<EBS_Order__c> ebsOrderRecordList = getEBSOrderRecord(ebsOrderTestRecord.Id);
        system.assert(ebsOrderRecordList.get(0).Shipping_Notif_Contact__c!=null , 'Shipping contact is not populated');

        Test.stopTest();
    }

    @isTest
    private static void insertEBSOrderRecordScenario02(){
        List<Account> accTestRecord = [SELECT Id FROM Account LIMIT 1];

        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        EBS_Order__c ebsOrderTestRecord = new EBS_Order__c(Account_Name__c = accTestRecord.get(0).Id,Order_Confirmation_Email__c='testOrderKoozie@test.com.full',Shipping_Notification_Email__c='testShippingKoozie@test.com.full');
        INSERT ebsOrderTestRecord;
        List<EBS_Order__c> ebsOrderRecordList = getEBSOrderRecord(ebsOrderTestRecord.Id);
        system.assert(ebsOrderRecordList.get(0).Shipping_Notif_Contact__c!=null , 'Shipping contact is not populated');
        system.assert(ebsOrderRecordList.get(0).Order_Confirm_Contact__c!=null,'Order contact is not populated');

        Test.stopTest();
    }
    
    @isTest
    private static void insertEBSOrderRecordScenario1(){
        List<Account> accTestRecord = [SELECT Id FROM Account LIMIT 1];

        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        EBS_Order__c ebsOrderTestRecord = TestData.createEBSOrderPOContactEmail(false,accTestRecord.get(0).Id,'pocontacttest@koozie.com');
        INSERT ebsOrderTestRecord;

        List<EBS_Order__c> ebsOrderRecordList = getEBSOrderRecord(ebsOrderTestRecord.Id);
        System.assertEquals('pocontacttest@koozie.com',ebsOrderRecordList.get(0).Order_Confirmation_Email__c , 'PO & Order Email are Different');
        System.assertEquals('pocontacttest@koozie.com',ebsOrderRecordList.get(0).Shipping_Notification_Email__c , 'PO & Shipping Email are Different');

        Test.stopTest();
    }

    @isTest
    private static void insertEBSOrderRecordScenario2(){
        List<Account> accTestRecord = [SELECT Id FROM Account LIMIT 1];

        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        EBS_Order__c ebsOrderTestRecord = TestData.createEBSOrderPOContactEmail(false,accTestRecord.get(0).Id,'pocontacttest@koozie.com');
        ebsOrderTestRecord.Order_Confirmation_Email__c = 'pocontacttest@koozie.com';
        ebsOrderTestRecord.Shipping_Notification_Email__c = 'shippingcontacttest@koozie.com';
        ebsOrderTestRecord.Sales_Contact__c = 'pocontacttest@koozie.com';
        INSERT ebsOrderTestRecord;

        List<EBS_Order__c> ebsOrderRecordList = getEBSOrderRecord(ebsOrderTestRecord.Id);
        system.assertEquals('pocontacttest@koozie.com',ebsOrderRecordList.get(0).Order_Confirmation_Email__c , 'PO & Order Email are Different');
        system.assertNotEquals('pocontacttest@koozie.com',ebsOrderRecordList.get(0).Shipping_Notification_Email__c , 'PO & Shipping Email are same');
        
        system.assert(ebsOrderRecordList.get(0).PO_Contact__c!=null,'PO Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).Order_Confirm_Contact__c!=null,'Order Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).Shipping_Notif_Contact__c!=null,'Shipping Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).SalesContact__c!=null,'Sales Contact was not populated');

        Test.stopTest(); 
    }

    @isTest
    private static void insertEBSOrderRecordScenarioSales2(){
        List<Account> accTestRecord = [SELECT Id FROM Account LIMIT 1];

        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        EBS_Order__c ebsOrderTestRecord = TestData.createEBSOrderPOContactEmail(false,accTestRecord.get(0).Id,'pocontacttest@koozie.com');
        ebsOrderTestRecord.Order_Confirmation_Email__c = 'pocontacttest@koozie.com';
        ebsOrderTestRecord.Shipping_Notification_Email__c = 'shippingcontacttest@koozie.com';
        ebsOrderTestRecord.Sales_Contact__c = 'salescontacttest@koozie.com';
        INSERT ebsOrderTestRecord;

        List<EBS_Order__c> ebsOrderRecordList = getEBSOrderRecord(ebsOrderTestRecord.Id);
        system.assertEquals('pocontacttest@koozie.com',ebsOrderRecordList.get(0).Order_Confirmation_Email__c , 'PO & Order Email are Different');
        system.assertNotEquals('pocontacttest@koozie.com',ebsOrderRecordList.get(0).Shipping_Notification_Email__c , 'PO & Shipping Email are same');
        
        system.assert(ebsOrderRecordList.get(0).PO_Contact__c!=null,'PO Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).Order_Confirm_Contact__c!=null,'Order Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).Shipping_Notif_Contact__c!=null,'Shipping Contact was not populated');

        Test.stopTest(); 
    }
    

    @isTest
    private static void insertEBSOrderRecordScenario3(){
        List<Account> accTestRecord = [SELECT Id FROM Account LIMIT 1];

        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        EBS_Order__c ebsOrderTestRecord = TestData.createEBSOrderPOContactEmail(false,accTestRecord.get(0).Id,'pocontacttest@koozie.com');
        ebsOrderTestRecord.Order_Confirmation_Email__c = 'ordercontacttest@koozie.com';
        ebsOrderTestRecord.Shipping_Notification_Email__c = 'pocontacttest@koozie.com';
        ebsOrderTestRecord.Sales_Contact__c = 'pocontacttest@koozie.com';
        INSERT ebsOrderTestRecord;

        List<EBS_Order__c> ebsOrderRecordList = getEBSOrderRecord(ebsOrderTestRecord.Id);
        system.assertEquals('pocontacttest@koozie.com',ebsOrderRecordList.get(0).Shipping_Notification_Email__c , 'PO & Shipping Email are Different');
        system.assertNotEquals('pocontacttest@koozie.com',ebsOrderRecordList.get(0).Order_Confirmation_Email__c , 'PO & Order Email are same');
        
        system.assert(ebsOrderRecordList.get(0).PO_Contact__c!=null,'PO Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).Order_Confirm_Contact__c!=null,'Order Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).Shipping_Notif_Contact__c!=null,'Shipping Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).SalesContact__c!=null,'Sales Contact was not populated');

        Test.stopTest(); 
    }

    @isTest
    private static void insertEBSOrderRecordScenarioSales3(){
        List<Account> accTestRecord = [SELECT Id FROM Account LIMIT 1];

        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        EBS_Order__c ebsOrderTestRecord = TestData.createEBSOrderPOContactEmail(false,accTestRecord.get(0).Id,'pocontacttest@koozie.com');
        ebsOrderTestRecord.Order_Confirmation_Email__c = 'ordercontacttest@koozie.com';
        ebsOrderTestRecord.Shipping_Notification_Email__c = 'pocontacttest@koozie.com';
        ebsOrderTestRecord.Sales_Contact__c = 'salescontacttest@koozie.com';
        INSERT ebsOrderTestRecord;

        List<EBS_Order__c> ebsOrderRecordList = getEBSOrderRecord(ebsOrderTestRecord.Id);
        system.assertEquals('pocontacttest@koozie.com',ebsOrderRecordList.get(0).Shipping_Notification_Email__c , 'PO & Shipping Email are Different');
        system.assertNotEquals('pocontacttest@koozie.com',ebsOrderRecordList.get(0).Order_Confirmation_Email__c , 'PO & Order Email are same');
        
        system.assert(ebsOrderRecordList.get(0).PO_Contact__c!=null,'PO Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).Order_Confirm_Contact__c!=null,'Order Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).Shipping_Notif_Contact__c!=null,'Shipping Contact was not populated');

        Test.stopTest(); 
    }

    @isTest
    private static void insertEBSOrderRecordScenario4(){
        List<Account> accTestRecord = [SELECT Id FROM Account LIMIT 1];

        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        EBS_Order__c ebsOrderTestRecord = TestData.createEBSOrderPOContactEmail(false,accTestRecord.get(0).Id,'pocontacttest@koozie.com');
        ebsOrderTestRecord.Order_Confirmation_Email__c = 'ordershippingcontacttest@koozie.com';
        ebsOrderTestRecord.Shipping_Notification_Email__c = 'ordershippingcontacttest@koozie.com';
        ebsOrderTestRecord.Sales_Contact__c = 'ordershippingcontacttest@koozie.com';
        INSERT ebsOrderTestRecord;

        List<EBS_Order__c> ebsOrderRecordList = getEBSOrderRecord(ebsOrderTestRecord.Id);
        system.assertEquals('ordershippingcontacttest@koozie.com',ebsOrderRecordList.get(0).Shipping_Notification_Email__c , 'Order & Shipping Email are Different');
        system.assertNotEquals('pocontacttest@koozie.com',ebsOrderRecordList.get(0).Order_Confirmation_Email__c , 'PO & Order Email are same');
        system.assertNotEquals('pocontacttest@koozie.com',ebsOrderRecordList.get(0).Shipping_Notification_Email__c , 'PO & Notification Email are same');

        system.assert(ebsOrderRecordList.get(0).PO_Contact__c!=null,'PO Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).Order_Confirm_Contact__c!=null,'Order Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).Shipping_Notif_Contact__c!=null,'Shipping Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).SalesContact__c!=null,'Sales Contact was not populated');
        
        Test.stopTest(); 
    }

    @isTest
    private static void insertEBSOrderRecordScenarioSales4(){
        List<Account> accTestRecord = [SELECT Id FROM Account LIMIT 1];

        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        EBS_Order__c ebsOrderTestRecord = TestData.createEBSOrderPOContactEmail(false,accTestRecord.get(0).Id,'pocontacttest@koozie.com');
        ebsOrderTestRecord.Order_Confirmation_Email__c = 'ordershippingcontacttest@koozie.com';
        ebsOrderTestRecord.Shipping_Notification_Email__c = 'ordershippingcontacttest@koozie.com';
        ebsOrderTestRecord.Sales_Contact__c = 'salescontacttest@koozie.com';
        INSERT ebsOrderTestRecord;

        List<EBS_Order__c> ebsOrderRecordList = getEBSOrderRecord(ebsOrderTestRecord.Id);
        system.assertEquals('ordershippingcontacttest@koozie.com',ebsOrderRecordList.get(0).Shipping_Notification_Email__c , 'Order & Shipping Email are Different');
        system.assertNotEquals('pocontacttest@koozie.com',ebsOrderRecordList.get(0).Order_Confirmation_Email__c , 'PO & Order Email are same');
        system.assertNotEquals('pocontacttest@koozie.com',ebsOrderRecordList.get(0).Shipping_Notification_Email__c , 'PO & Notification Email are same');

        system.assert(ebsOrderRecordList.get(0).PO_Contact__c!=null,'PO Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).Order_Confirm_Contact__c!=null,'Order Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).Shipping_Notif_Contact__c!=null,'Shipping Contact was not populated');
        
        Test.stopTest(); 
    }

    @isTest
    private static void insertEBSOrderRecordScenario5(){
        List<Account> accTestRecord = [SELECT Id FROM Account LIMIT 1];

        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        EBS_Order__c ebsOrderTestRecord = TestData.createEBSOrderPOContactEmail(false,accTestRecord.get(0).Id,'pocontacttest@koozie.com');
        ebsOrderTestRecord.Order_Confirmation_Email__c = 'ordercontacttest@koozie.com';
        ebsOrderTestRecord.Shipping_Notification_Email__c = 'shippingcontacttest@koozie.com';
        ebsOrderTestRecord.Sales_Contact__c = 'salescontacttest@koozie.com';
        INSERT ebsOrderTestRecord;

        List<EBS_Order__c> ebsOrderRecordList = getEBSOrderRecord(ebsOrderTestRecord.Id);
        system.assertNotEquals('pocontacttest@koozie.com',ebsOrderRecordList.get(0).Order_Confirmation_Email__c , 'Order & Shipping Email are same');
        system.assertNotEquals('pocontacttest@koozie.com',ebsOrderRecordList.get(0).Shipping_Notification_Email__c , 'PO & Shipping Email are same');
        system.assertNotEquals('ordercontacttest@koozie.com',ebsOrderRecordList.get(0).Shipping_Notification_Email__c , 'Order & shipping Email are same');

        system.assert(ebsOrderRecordList.get(0).PO_Contact__c!=null,'PO Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).Order_Confirm_Contact__c!=null,'Order Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).Shipping_Notif_Contact__c!=null,'Shipping Contact was not populated');
        
        Test.stopTest(); 
    }

    @isTest
    private static void insertEBSOrderRecordScenarioSales5(){
        List<Account> accTestRecord = [SELECT Id FROM Account LIMIT 1];

        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        EBS_Order__c ebsOrderTestRecord = TestData.createEBSOrderPOContactEmail(false,accTestRecord.get(0).Id,'pocontacttest@koozie.com');
        ebsOrderTestRecord.Order_Confirmation_Email__c = 'ordercontacttest@koozie.com';
        ebsOrderTestRecord.Shipping_Notification_Email__c = 'shippingcontacttest@koozie.com';
        ebsOrderTestRecord.Sales_Contact__c = 'shippingcontacttest@koozie.com';
        INSERT ebsOrderTestRecord;

        List<EBS_Order__c> ebsOrderRecordList = getEBSOrderRecord(ebsOrderTestRecord.Id);
        system.assertNotEquals('pocontacttest@koozie.com',ebsOrderRecordList.get(0).Order_Confirmation_Email__c , 'Order & Shipping Email are same');
        system.assertNotEquals('pocontacttest@koozie.com',ebsOrderRecordList.get(0).Shipping_Notification_Email__c , 'PO & Shipping Email are same');
        system.assertNotEquals('ordercontacttest@koozie.com',ebsOrderRecordList.get(0).Shipping_Notification_Email__c , 'Order & shipping Email are same');

        system.assert(ebsOrderRecordList.get(0).PO_Contact__c!=null,'PO Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).Order_Confirm_Contact__c!=null,'Order Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).Shipping_Notif_Contact__c!=null,'Shipping Contact was not populated');
        system.assert(ebsOrderRecordList.get(0).SalesContact__c!=null,'Sales Contact was not populated');
        
        Test.stopTest(); 
    }

    @isTest
    private static void updateEBSOrderRecordScenario1(){
        List<Account> accTestRecord = [SELECT Id FROM Account LIMIT 1];
        
        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        EBS_Order__c ebsOrderTestRecord = TestData.createEBSOrderPOContactEmail(false,accTestRecord.get(0).Id,'pocontacttest@koozie.com.full');
        INSERT ebsOrderTestRecord;

        List<EBS_Order__c> ebsOrderRecordList = getEBSOrderRecord(ebsOrderTestRecord.Id);
        ebsOrderRecordList.get(0).PO_Contact_Email__c = 'pocontact2test@koozie.com.full';
        UPDATE ebsOrderRecordList;
        system.assert(String.isNotBlank(ebsOrderRecordList.get(0).PO_Contact_Email__c), 'PO Email is null');
        Test.stopTest();

    }

    private static List<EBS_Order__c> getEBSOrderRecord(String ebdOrderId){
        return [Select Id,PO_Contact_Email__c,Order_Confirmation_Email__c,Shipping_Notification_Email__c,PO_Contact__c,Order_Confirm_Contact__c,Shipping_Notif_Contact__c,SalesContact__c, Sales_Contact__c From EBS_Order__c WHERE ID =:ebdOrderId];
    }

}