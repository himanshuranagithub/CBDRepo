public class Accountdetails {
    @AuraEnabled(cacheable=true)
    public static List<Account>ShowListofAccount(){
        List<Account>Acclist = new List<Account>();
        Acclist = [SELECT ID,Name,Rating,Phone from Account LIMIT 10];
        return Acclist;
    }

}