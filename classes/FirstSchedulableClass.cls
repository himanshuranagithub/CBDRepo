public class FirstSchedulableClass implements Schedulable {
    public void execute(SchedulableContext sc) {
        // Logic for the first scheduled job
        System.debug('First Schedulable Job is running.');

        // Schedule the second job to run after a specific time
        String cronExp = '0 0 12 * * ?'; // This cron expression runs daily at 12 PM
        System.schedule('Second Schedulable Job', cronExp, new SecondSchedulableClass());
    }
}

 // Schedule revert commit 3