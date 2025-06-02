@isTest
public class OpportunitytriggereHandlertest {
 @isTest
    public static void populateLatestOppAmount(){
        List<Account>acclist =new list<Account>();
        List<Opportunity>opplist = new list<Opportunity>();
        for(Integer i=1; i<=5; i++){
            Account acc =new Account();
            acc.Name = 'Test'+i;
            acclist.add(acc);
            
        }
        insert acclist;
        for(Account acc : acclist){
            Opportunity opp =new Opportunity();
            opp.Name =acc.Name;
            opp.StageName='Prospecting';
            opp.CloseDate= system.Today();
            opp.Amount=200000;
            opp.AccountId=acc.Id;
            opplist.add(opp);
  
        }
        test.startTest();
        insert opplist;
        test.stopTest();
        List <Account> UpdatedAcc =[Select id,Latestoppamount__c from Account where id=:acclist[0].id];
        system.assertEquals(200000, UpdatedAcc[0].Latestoppamount__c );
            
        
    }
    
     @isTest
    public static void  CreatTask(){
        
        List<Opportunity>opplist = new list<Opportunity>();
        for(Integer i=1; i<=5; i++){
            Opportunity opp =new Opportunity();
            opp.Name = 'Test'+i;
            opp.StageName='Prospecting';
            opp.CloseDate=system.today();
            opp.Amount=20000;
            opplist.add(opp);
            
        }
        Test.startTest();
        insert opplist;
        for(Opportunity opp: opplist){
            opp.StageName='Value Proposition';
        }
        update opplist;
        List<Task>taskList =[Select Id from Task where WhatId=:opplist[0].Id];
        System.assertEquals(1, tasklist.size());
    }
}