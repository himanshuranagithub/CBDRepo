public class ContactTriggerHandler {
    public static void findDuplicateContact(List<contact> cnnlist){
        for(Contact con : cnnlist){
            list<Contact>conlist=[Select id, Name, Email from Contact where Name=:con.Name or Email=:con.Email];
            if(conlist.size()>0){
                con.addError('This is a duplicat contact');
            }
        }
        
    }

}