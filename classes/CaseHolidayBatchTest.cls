@isTest
private class CaseHolidayBatchTest {
    
    @testSetup
    private static void createTestData() {
        
        Profile pf = [SELECT Id,Name FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        
        User usr = new User(
            Alias = 'usralias',
            Email  = 'theuser@email.com',
            Emailencodingkey= 'UTF-8',
            Lastname = 'user_lastname',
            Languagelocalekey = 'en_US',
            Localesidkey = 'en_US',
            Profileid  =  pf.Id,
            Timezonesidkey = 'America/Los_Angeles',
            Username =  Math.random() + 'test@testuser.com',
            CompanyName  = 'the company'
        );
        insert usr;
        
        Case ca = new case ();
        
        ca.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Case').getRecordTypeId();
        ca.EBS_Account_Number__c ='12345';
        ca.Status = 'New';
        ca.Origin = 'ASI Rating';
        ca.CreatedDate = System.today()-5;
        insert ca;
        
        System.runAs(usr) {
            Holiday ho = new Holiday();
            ho.Name = 'test holidays';
            ho.ActivityDate = System.today()-3 ;
            insert ho;
            
            System.debug(' Holiday holidays: ' + ho);    
        }
        
    }
    
    // Test for the Scheduler
    @isTest
    static void testSchedulerExecution() {
        // Start the test
        Test.startTest();
        
        // Schedule the job
        String jobName = 'CaseHolidaySchedulerTest';
        CaseHolidayScheduler scheduler = new CaseHolidayScheduler();
        String cronExpression = '0 0 0 1 1 ?'; // Example cron expression
        System.schedule(jobName, cronExpression, scheduler);
        
        Test.stopTest();
        
        // Verify job has been scheduled
        CronTrigger[] scheduledJobs = [SELECT Id, CronExpression, State FROM CronTrigger WHERE CronJobDetail.Name = :jobName];
        
        System.assertNotEquals(0, scheduledJobs.size(), 'Job was not scheduled.');
        System.assertEquals('WAITING', scheduledJobs[0].State, 'Job is not in WAITING state.');
        
    }
    
    @isTest
    static void testBatchProcessing() {
        // Start the test and execute the batch
        Test.startTest();
        
        // Create instance of the batch class
        CaseHolidayHoursBatch batch = new CaseHolidayHoursBatch();
        
        // Execute the batch with a scope of 2 records
        Database.executeBatch(batch, 2);
        
        Test.stopTest();
        
        // Verify results: Check that the cases were updated
        Case c = [SELECT Id, Holiday_Hours__c FROM Case LIMIT 1];
        System.assertEquals(12.5, c.Holiday_Hours__c, 'Holiday Hours updated.'); 
        
    }
}