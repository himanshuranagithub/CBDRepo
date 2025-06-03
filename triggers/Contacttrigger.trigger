trigger Contacttrigger on Contact (before insert,before update) {
    for(Contact con:Trigger.new){
        if(con.Last_name__c =='Himanshu'){
            con.Last_name__c = 'Krishna';
        }
    }
    
}