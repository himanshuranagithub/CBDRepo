public class SecondBatchClass implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext context) {
        // Query to fetch the records to be processed in the second batch
        return Database.getQueryLocator('SELECT Id, Name FROM Contact WHERE CreatedDate = LAST_N_DAYS:30');
    }
    
    public void execute(Database.BatchableContext context, List<SObject> scope) {
        // Process each batch of records
        for (SObject sObj : scope) {
            Contact con = (Contact)sObj;
            System.debug('Second Batch Processing Contact: ' + con.Name);
            // Your processing logic here
        }
    }
    
    public void finish(Database.BatchableContext context) {
        // Logic to run after all batches are processed
        String dailyCronExp = '0 0 0 * * ?'; // Daily at 12:00 AM
        System.schedule('Daily Data Cleanup Job', dailyCronExp, new DailyDataCleanupJob());
        System.debug('Second batch processing completed.');
    }
}