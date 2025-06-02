trigger Checkduplicatename on Contact (before insert) {
    for(Contact con:Trigger.new){
        list<Contact>conlist=[SELECT Id, FirstName from Contact Where FirstName=:con.FirstName ];
        if(conlist.size()>0){
            con.adderror('This is duplicate name');
        }
    }
    
}