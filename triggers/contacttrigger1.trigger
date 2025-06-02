trigger contacttrigger1 on Contact (before insert) {
    for(Contact con:Trigger.new){
        if(con.FirstName==con.LastName){
            con.addError('Contact firstname and lastname should not be same');
        }
    }
}