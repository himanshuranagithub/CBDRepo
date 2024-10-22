public class hotRating {
    public static void hot(List <Account> newAccList){
        system.debug(newAccList);
        List <account> accList = [select id , rating  , (select id , amount from opportunities) from account where id in:newAccList ];
        system.debug(accList);
        List<opportunity> updateOppList = new List<opportunity>();   
        for(Account acc: acclist){
        if(acc.Rating == 'Hot'){ 
            for(opportunity opp : acc.opportunities ){
                opp.amount = 500 ; 
                updateOppList.add(opp);
                
            }
        }
        }
        
        system.debug(updateOppList);
        update updateOppList;
    }
    
}