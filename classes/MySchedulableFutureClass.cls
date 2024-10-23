public class MySchedulableFutureClass implements Schedulable {
    public void execute(SchedulableContext context) {
        // Enqueue the Future job
        MyFutureClass.myFutureMethod('example parameter');
    }
}