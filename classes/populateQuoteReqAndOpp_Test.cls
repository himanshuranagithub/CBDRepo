@isTest
public class populateQuoteReqAndOpp_Test {
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
    public static void testMethodForOppAndQuoteCreation(){
        Id accRecTypId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customers').getRecordTypeId();
        Id conRecTypId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('CRM Contact').getRecordTypeId();
        Map<String,EBS_Order__c> quoteNumOrderMap = new Map<String,EBS_Order__c>();
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.RecordTypeId = accRecTypId;
        acc.Customer_Account_Number__c = '12345678';
        acc.Customer_PO_Number__c = '123456';
        insert acc;
        
        Contact cont = new Contact();
        cont.firstname = 'First';
        cont.lastname = 'Test Name';  
        cont.AccountId = acc.Id;
        cont.Email = 'firsttestname@testing.com';
        cont.Phone = '407-508-1313';
        cont.RecordTypeId = conRecTypId;
        cont.Acc_PO_Contact__c = True;
        insert cont;
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.StageName = 'Proposal';
        opp.CloseDate = System.today();
        // Quote_Number__c = 'OQR-034477';
        insert opp;    
        Opportunity oppquotenumber = [SELECT Quote_Number__c FROM Opportunity WHERE Quote_Number__c LIKE '%QR%' LIMIT 1];
        //Without Case
        EBS_Order__c eo = new EBS_Order__c();
        eo.Account_Name__c = acc.Id;
        eo.PO_Contact__c = cont.Id;
        eo.PO_Contact_Email__c = 'contact1@ebsorder.com'; 
        eo.Customer_Account_Number__c = '1234567'; 
        eo.Order_Type__c = 'Standard';
        eo.Customer_PO__c = 'PK11001436L1';
        eo.Quote_Number__c = 'QR-144031';
        eo.Quote_Number__c = oppquotenumber.Quote_Number__c;
        eo.EBS_Order_Number__c = '27903373661';
        insert eo;
        eo.Opportunity__c = opp.Id;
        update eo;
        Quote_Request__c qr = new Quote_Request__c();
        qr.Contact__c = cont.Id;
        qr.Account__c = acc.Id;
        qr.Opportunity__c = opp.Id;
        insert qr;
        List<EBS_Order__c> eoList = new List<EBS_Order__c>(); 
        eoList.add(eo);
        quoteNumOrderMap.put('QR-14403',eo);
        
        // Test.startTest();
        populateQuoteReqAndOpp.updateOrderWithQuoteAndOpp(quoteNumOrderMap);
        Test.setMock(HttpCalloutMock.class, new RestMock());
    }
    @isTest
    public static void testupdateEBSOrder() {
        Id accRecTypId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customers').getRecordTypeId();
        Id conRecTypId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('CRM Contact').getRecordTypeId();
        Map<String,EBS_Order__c> quoteNumOrderMap = new Map<String,EBS_Order__c>();
        Account acc1 = new Account();
        acc1.Name = 'Test Account2';
        acc1.RecordTypeId = accRecTypId;
        acc1.Customer_Account_Number__c = '123456787';
        acc1.Customer_PO_Number__c = '12345667';
        insert acc1;
        
        Contact cont = new Contact();
        cont.firstname = 'First';
        cont.lastname = 'Test Name';  
        cont.AccountId = acc1.Id;
        cont.Email = 'firsttestname@testing.com';
        cont.Phone = '407-508-1313';
        cont.RecordTypeId = conRecTypId;
        cont.Acc_PO_Contact__c = True;
        insert cont;
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.StageName = 'Proposal';
        opp.CloseDate = System.today();
        // opp.Quote_Number__c = 'QR-14403';
        insert opp;       
        Opportunity oppquotenumber = [SELECT Quote_Number__c FROM Opportunity WHERE Quote_Number__c LIKE '%OQR%' LIMIT 1];
        //Without Case
        EBS_Order__c eo = new EBS_Order__c();
        eo.Account_Name__c = acc1.Id;
        eo.PO_Contact__c = cont.Id;
        eo.PO_Contact_Email__c = 'contact@ebsorder.com'; 
        eo.Customer_Account_Number__c = '123456'; 
        eo.Order_Type__c = 'Standard';
        eo.Customer_PO__c = 'PK11001436L';
        eo.Quote_Number__c = 'OQR-14403';
        eo.Quote_Number__c = oppquotenumber.Quote_Number__c;
        eo.EBS_Order_Number__c = '2790337366';
        insert eo;
        eo.Opportunity__c = opp.Id;
        update eo;
        //eo.Quote_Number__c = opp.Quote_Number__c;
        // update eo;
        List<EBS_Order__c> eoList = new List<EBS_Order__c>(); 
        eoList.add(eo);
        quoteNumOrderMap.put('QR-14403',eo);
        
        // Test.startTest();
        populateQuoteReqAndOpp.updateOrderWithQuoteAndOpp(quoteNumOrderMap);
        Test.setMock(HttpCalloutMock.class, new RestMock());
        // Test.stopTest();
        
    }
    @isTest
    public static void testupdateEBSOrderFromQuote() {
        Id accRecTypId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customers').getRecordTypeId();
        Id conRecTypId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('CRM Contact').getRecordTypeId();
        Map<String,EBS_Order__c> quoteNumOrderMap = new Map<String,EBS_Order__c>();
        Account acc2 = new Account();
        acc2.Name = 'Test Account2';
        acc2.RecordTypeId = accRecTypId;
        acc2.Customer_Account_Number__c = '123456789';
        acc2.Customer_PO_Number__c = '1234567';
        insert acc2;
        
        Contact cont = new Contact();
        cont.firstname = 'First';
        cont.lastname = 'Test Name';  
        cont.AccountId = acc2.Id;
        cont.Email = 'firsttestname@testing.com';
        cont.Phone = '407-508-1313';
        cont.RecordTypeId = conRecTypId;
        cont.Acc_PO_Contact__c = True;
        insert cont;
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.StageName = 'Proposal';
        opp.CloseDate = System.today(); 
        insert opp;        
        //Without Case
        Quote_Request__c qr = new Quote_Request__c();
        qr.Contact__c = cont.Id;
        qr.Account__c = acc2.Id;
        qr.Opportunity__c = opp.Id;
        insert qr;
        Quote_Request__c quotenumber = [SELECT Quote_Number__c FROM Quote_Request__c WHERE Quote_Number__c LIKE '%Q%' LIMIT 1];
        EBS_Order__c eo = new EBS_Order__c();
        eo.Account_Name__c = acc2.Id;
        eo.PO_Contact__c = cont.Id;
        eo.PO_Contact_Email__c = 'contact@ebsorder.com'; 
        eo.Customer_Account_Number__c = '123456'; 
        eo.Order_Type__c = 'Standard';
        eo.Customer_PO__c = 'PK11001436L';
        eo.Quote_Number__c = 'QR-14403';
        eo.EBS_Order_Number__c = '2790337366';
        insert eo;
        eo.Quote_Request__c = qr.Id;
        update eo;
        
        Test.startTest();
        List<EBS_Order__c> eoList = new List<EBS_Order__c>(); 
        eoList.add(eo);
        quoteNumOrderMap.put('QR-14403',eo);
        
        populateQuoteReqAndOpp.updateOrderWithQuoteAndOpp(quoteNumOrderMap);
        Test.setMock(HttpCalloutMock.class, new RestMock());
        Test.stopTest();
        
    }
       @isTest
    static void testUpdateOrderWithQuoteAndOpp() {
        // Create test data
        Opportunity opp = new Opportunity(Name = 'Test Opportunity',CloseDate = System.today(), StageName = 'Prospecting');
        insert opp;
        
        Quote_Request__c qr = new Quote_Request__c(Opportunity__c = opp.Id);
        insert qr;
        
        EBS_Order__c order1 = new EBS_Order__c(Quote_Number__c = 'OQR-12345');
        EBS_Order__c order2 = new EBS_Order__c(Quote_Number__c = 'QR-12345');
        EBS_Order__c order3 = new EBS_Order__c(Quote_Number__c = 'Invalid-123');
        
        Map<String, EBS_Order__c> quoteNumOrderMap = new Map<String, EBS_Order__c>();
        quoteNumOrderMap.put(order1.Quote_Number__c, order1);
        quoteNumOrderMap.put(order2.Quote_Number__c, order2);
        quoteNumOrderMap.put(order3.Quote_Number__c, order3);
        
        Test.startTest();
        // Call the method to be tested
        populateQuoteReqAndOpp.updateOrderWithQuoteAndOpp(quoteNumOrderMap);
        Test.setMock(HttpCalloutMock.class, new RestMock());
        Test.stopTest();
        
        // Retrieve the updated orders
        List<EBS_Order__c> queriedOrders = [SELECT Id, Opportunity__c FROM EBS_Order__c WHERE Quote_Number__c IN :quoteNumOrderMap.keySet()];
        
        // Assert the results
        for(EBS_Order__c queriedOrder : queriedOrders) {
            if(queriedOrder.Quote_Number__c == order1.Quote_Number__c) {
                System.assertEquals(opp.Id, queriedOrder.Opportunity__c, 'Order with OQR should be associated with Opportunity');
            } else if(queriedOrder.Quote_Number__c == order2.Quote_Number__c) {
                System.assertEquals(qr.Id, queriedOrder.Quote_Request__c, 'Order with QR should be associated with Quote Request');
                System.assertEquals(opp.Id, queriedOrder.Opportunity__c, 'Order with QR should also be associated with Opportunity');
            } else {
                System.assertEquals(null, queriedOrder.Opportunity__c, 'Order with invalid Quote Number should not be associated with Opportunity');
                System.assertEquals(null, queriedOrder.Quote_Request__c, 'Order with invalid Quote Number should not be associated with Quote Request');
            }
        }
    }
    
      @isTest
    static void testUpdateOrderWithQuoteAndOpp1() {
        // Test with empty map
        populateQuoteReqAndOpp.updateOrderWithQuoteAndOpp(new Map<String, EBS_Order__c>());
        
        // Create test data
        Opportunity opp = new Opportunity(Name = 'Test Opportunity',CloseDate = System.today(), StageName = 'Prospecting');
        insert opp;
        
        Quote_Request__c qr = new Quote_Request__c(Opportunity__c = opp.Id);
        insert qr;
        
        EBS_Order__c order1 = new EBS_Order__c(Quote_Number__c = 'OQR-12345');
        EBS_Order__c order2 = new EBS_Order__c(Quote_Number__c = 'QR-12345');
        EBS_Order__c order3 = new EBS_Order__c(Quote_Number__c = 'Invalid-123');
        
        Map<String, EBS_Order__c> quoteNumOrderMap = new Map<String, EBS_Order__c>();
        quoteNumOrderMap.put(order1.Quote_Number__c, order1);
        quoteNumOrderMap.put(order2.Quote_Number__c, order2);
        quoteNumOrderMap.put(order3.Quote_Number__c, order3);
        
        Test.startTest();
        // Call the method to be tested
        populateQuoteReqAndOpp.updateOrderWithQuoteAndOpp(quoteNumOrderMap);
        Test.setMock(HttpCalloutMock.class, new RestMock());
        Test.stopTest();
        
        // Retrieve the updated orders
        List<EBS_Order__c> queriedOrders = [SELECT Id, Opportunity__c FROM EBS_Order__c WHERE Quote_Number__c IN :quoteNumOrderMap.keySet()];
        
        // Assert the results
        for(EBS_Order__c queriedOrder : queriedOrders) {
            if(queriedOrder.Quote_Number__c == order1.Quote_Number__c) {
                System.assertEquals(opp.Id, queriedOrder.Opportunity__c, 'Order with OQR should be associated with Opportunity');
            } else if(queriedOrder.Quote_Number__c == order2.Quote_Number__c) {
                System.assertEquals(qr.Id, queriedOrder.Quote_Request__c, 'Order with QR should be associated with Quote Request');
                System.assertEquals(opp.Id, queriedOrder.Opportunity__c, 'Order with QR should also be associated with Opportunity');
            } else {
                System.assertEquals(null, queriedOrder.Opportunity__c, 'Order with invalid Quote Number should not be associated with Opportunity');
                System.assertEquals(null, queriedOrder.Quote_Request__c, 'Order with invalid Quote Number should not be associated with Quote Request');
            }
        }
    }
    
    @isTest
    static void testUpdateOrderWithQuoteAndOpp2() {
        // Test with empty map
        populateQuoteReqAndOpp.updateOrderWithQuoteAndOpp(new Map<String, EBS_Order__c>());
        
        // Create test data
        Opportunity opp = new Opportunity(Name = 'Test Opportunity',CloseDate = System.today(), StageName = 'Prospecting');
        insert opp;
        
        Quote_Request__c qr = new Quote_Request__c(Opportunity__c = opp.Id);
        insert qr;
        
        EBS_Order__c order1 = new EBS_Order__c(Quote_Number__c = 'OQR-12345');
        EBS_Order__c order2 = new EBS_Order__c(Quote_Number__c = 'QR-12345');
        EBS_Order__c order3 = new EBS_Order__c(Quote_Number__c = 'Invalid-123');
        
        Map<String, EBS_Order__c> quoteNumOrderMap = new Map<String, EBS_Order__c>();
        quoteNumOrderMap.put(order1.Quote_Number__c, order1);
        quoteNumOrderMap.put(order2.Quote_Number__c, order2);
        quoteNumOrderMap.put(order3.Quote_Number__c, order3);
        
        Test.startTest();
        // Call the method to be tested
        populateQuoteReqAndOpp.updateOrderWithQuoteAndOpp(quoteNumOrderMap);
        Test.stopTest();
        
        // Retrieve the updated orders
        List<EBS_Order__c> queriedOrders = [SELECT Id, Opportunity__c FROM EBS_Order__c WHERE Quote_Number__c IN :quoteNumOrderMap.keySet()];
        
        // Assert the results
        for(EBS_Order__c queriedOrder : queriedOrders) {
            if(queriedOrder.Quote_Number__c == order1.Quote_Number__c) {
                System.assertEquals(opp.Id, queriedOrder.Opportunity__c, 'Order with OQR should be associated with Opportunity');
            } else if(queriedOrder.Quote_Number__c == order2.Quote_Number__c) {
                System.assertEquals(qr.Id, queriedOrder.Quote_Request__c, 'Order with QR should be associated with Quote Request');
                System.assertEquals(opp.Id, queriedOrder.Opportunity__c, 'Order with QR should also be associated with Opportunity');
            } else {
                System.assertEquals(null, queriedOrder.Opportunity__c, 'Order with invalid Quote Number should not be associated with Opportunity');
                System.assertEquals(null, queriedOrder.Quote_Request__c, 'Order with invalid Quote Number should not be associated with Quote Request');
            }
        }
    }
    
      @isTest
    static void testUpdateOrderWithQuoteAndOpp3() {
        // Create test data
        Opportunity opp = new Opportunity(Name = 'Test Opportunity',CloseDate = System.today(), StageName = 'Prospecting');
        insert opp;
        
        // Create Quote Request with auto-generated Name
        Quote_Request__c qr = new Quote_Request__c(Opportunity__c = opp.Id); // No need to set Name
        insert qr;
        
        EBS_Order__c order1 = new EBS_Order__c(Quote_Number__c = 'OQR-12345');
        EBS_Order__c order2 = new EBS_Order__c(Quote_Number__c = 'QR-' + qr.Id); // Use Quote_Request__c Id to simulate Name
        EBS_Order__c order3 = new EBS_Order__c(Quote_Number__c = 'Invalid-123');
        
        Map<String, EBS_Order__c> quoteNumOrderMap = new Map<String, EBS_Order__c>();
        quoteNumOrderMap.put(order1.Quote_Number__c, order1);
        quoteNumOrderMap.put(order2.Quote_Number__c, order2);
        quoteNumOrderMap.put(order3.Quote_Number__c, order3);
        
        Test.startTest();
        // Call the method to be tested
        populateQuoteReqAndOpp.updateOrderWithQuoteAndOpp(quoteNumOrderMap);
        Test.stopTest();
        
        // Verify the behavior
        List<EBS_Order__c> queriedOrders = [SELECT Id, Opportunity__c, Quote_Request__c FROM EBS_Order__c WHERE Quote_Number__c IN :quoteNumOrderMap.keySet()];
        
        for(EBS_Order__c queriedOrder : queriedOrders) {
            if(queriedOrder.Quote_Number__c == order1.Quote_Number__c) {
                System.assertEquals(opp.Id, queriedOrder.Opportunity__c, 'Order with OQR should be associated with Opportunity');
            } else if(queriedOrder.Quote_Number__c == order2.Quote_Number__c) {
                // Ensure Quote_Request__c is set
                System.assertNotEquals(null, queriedOrder.Quote_Request__c, 'Order with QR should be associated with Quote Request');
                // Ensure Opportunity__c is set
                System.assertNotEquals(null, queriedOrder.Opportunity__c, 'Order with QR should also be associated with Opportunity');
            } else {
                // Ensure Quote_Request__c and Opportunity__c are null for orders with invalid Quote Number
                System.assertEquals(null, queriedOrder.Opportunity__c, 'Order with invalid Quote Number should not be associated with Opportunity');
                System.assertEquals(null, queriedOrder.Quote_Request__c, 'Order with invalid Quote Number should not be associated with Quote Request');
            }
        }
    }
}