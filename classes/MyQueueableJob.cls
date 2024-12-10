public class MyQueueableJob implements Queueable {
    public void execute(QueueableContext context) {
        // Your queueable job logic here
        System.debug('Inside Queueable');
        //Database.executeBatch(new BatchToQueueable(), 200);
        //System.enqueueJob(new SecondQueueableClass());
        //MyFutureClass.myFutureMethod('example parameter');	
        System.debug('Queueable job is running.');
    }
}