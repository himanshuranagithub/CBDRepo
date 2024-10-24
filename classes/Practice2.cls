public class Practice2 {
    public static void oppCloseDateCheck(List<Opportunity> newlist){
        set<Id> accid= new Set<Id> ();
        if(newlist!= null){
            for(Opportunity opp: newlist){
                if(opp.AccountId != null){
                    accid.add(opp.AccountId);
                }
            }
        }
        Map<Id,List<Date>> accountIdToOppCloseDate =new Map<Id,List<Date>> ();
        if(accid.size()>0){
        List<Opportunity> opplist= [SELECT ID,Name,CloseDate,AccountId From Opportunity WHERE AccountId In: accid];
            for(Opportunity op : opplist){
                if(op.CloseDate != null){
                  accountIdToOppCloseDate.put(op.AccountId,new List<Date>());  
                }
                accountIdToOppCloseDate.get(op.AccountId).add(op.CloseDate);
            }
            for(Opportunity opp: newlist){
                if(accountIdToOppCloseDate.containsKey(opp.AccountId)){
                    List<Date> closedate = accountIdToOppCloseDate.get(opp.AccountId);
                    if(closedate.contains(opp.CloseDate)){
                        opp.addError('Duplicate CloseDate Value');
                    }
                }
            }
        
    }
    }

}