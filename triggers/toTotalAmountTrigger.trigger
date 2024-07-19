trigger toTotalAmountTrigger on Contact (after insert, after update) {
 Set<Id> getaccid = new set<Id>();
 
 for(Contact con : trigger.new){
   getaccid.add(con.accountId); 
 }
 List<Account> acclist = [Select Id, Name,Total_amount__c,(Select Id, Name,Amount__c from Contacts) from Account where Id In:getaccid];
 
 if(!acclist.isEmpty()){
  for(Account a: acclist){
     Decimal Sum = 0;
     for(Contact c : a.Contacts){
     Sum = Sum + c.Amount__c;
         a.Total_amount__c = Sum;
     }
     }
     
 }
 update acclist;
 

}