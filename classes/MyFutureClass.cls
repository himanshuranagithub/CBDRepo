public class MyFutureClass {
    @future
    public static void myFutureMethod(String param) {
        // Your future method logic here
        System.debug('Future method called with parameter: ' + param);
        //SecondFutureClass.mySecondFutureMethod('example parameter');
        //Database.executeBatch(new BatchToQueueable(), 200); // Adjust batch size as needed
        //System.enqueueJob(new MyQueueableJob());
    }
}