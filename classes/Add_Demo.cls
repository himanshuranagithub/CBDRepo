public class Add_Demo {
    public Integer a;
    public Integer b;
    public Integer c;
    
    public Integer addt(){
        c=a+b; 
        system.debug('Testing Backup1');
        system.debug('the result is'+c);
        system.debug('Source Org changes');
        return c;
    }
    
}