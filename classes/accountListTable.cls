public class accountListTable {
    @auraenabled
    public static List<Account> getAccounts(){
        List <Account> accList = new List<Account>();
        accList= [Select id,name,phone from Account];
        return accList;
    }

}