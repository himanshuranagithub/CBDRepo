public class MySchedulableJob implements Schedulable {
    public void execute(SchedulableContext context) {
        // Enqueue the Queueable job
        System.enqueueJob(new MyQueueableJob());
    }
}