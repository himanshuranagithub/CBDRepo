public class contactUpdateAccountClass {
    public static void contactUpdateAccountMethod(list<contact> conParam){
        set<id> accids = new set<id>();
        for(contact con:conParam){
            if(con.accountId != null){
                accids.add(con.accountId);
            }
        }
        list<account> accList = [select id,name,total_amount__c,(select id,Amount__c from contacts)from account where id in:accids];
        for(account acc:accList){
            acc.total_amount__c = acc.contacts.size();
            decimal sum = 0;
            for(contact con1: acc.contacts){
                sum = sum + con1.Amount__c;
            }
            acc.total_amount__c = sum;
            
            
            
        }
        update accList;
        
        
        
    }

}