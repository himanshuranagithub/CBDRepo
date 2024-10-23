public class MySchedulableBatchClass implements Schedulable {
    public void execute(SchedulableContext context) {
        // Enqueue the Batch job
        Database.executeBatch(new BatchToQueueable(), 200);
    }
}