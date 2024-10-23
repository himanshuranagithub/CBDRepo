public class SecondFutureClass {
    
    @future
    public static void mySecondFutureMethod(String param) {
        // Your future method logic here
        System.debug('Future method called with parameter: ' + param);
        String monthlyCronExp = '0 0 2 1 * ?'; // 1st day of every month at 2:00 AM
        System.schedule('Monthly Data Backup Job', monthlyCronExp, new MonthlyDataBackupJob());
        //Database.executeBatch(new BatchToQueueable(), 200); // Adjust batch size as needed
        //System.enqueueJob(new MyQueueableJob());
    }
    
}