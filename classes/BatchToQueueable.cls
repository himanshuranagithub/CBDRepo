public class BatchToQueueable implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext context) {
        // Query to fetch the records to be processed
        return Database.getQueryLocator('SELECT Id, Name FROM Account WHERE CreatedDate = LAST_N_DAYS:30 LIMIT 1');
    }
    
    public void execute(Database.BatchableContext context, List<SObject> scope) {
        // Process each batch of records
        for (SObject sObj : scope) {
            Account acc = (Account)sObj;
            System.debug('Batch Processing Account: ' + acc.Name);
            // Your processing logic here
        }
    }
    
    public void finish(Database.BatchableContext context) {
        // Logic to run after all batches are processed
        System.debug('Batch processing completed.');

        MyFutureClass.myFutureMethod('example parameter');
        //Database.executeBatch(new SecondBatchClass(), 200); 
        // Enqueue the Queueable job
        //System.enqueueJob(new MyQueueableJob());
    }
}