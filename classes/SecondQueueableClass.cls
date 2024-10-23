public class SecondQueueableClass implements Queueable {
    
    public void execute(QueueableContext context) {
        // Logic before calling the batch
        System.debug('Second Queueable job started.');
        String weeklyCronExp = '0 0 8 ? * MON'; // Every Monday at 8:00 AM
		System.schedule('Weekly Report Generation Job', weeklyCronExp, new WeeklyReportGenerationJob());
        // Call the batch job
    }
}