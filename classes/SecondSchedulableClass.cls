public class SecondSchedulableClass implements Schedulable {
    public void execute(SchedulableContext sc) {
        // Logic for the second scheduled job
        System.debug('Second Schedulable Job is running.');
    }
}