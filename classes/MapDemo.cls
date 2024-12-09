public class MapDemo {
    public static void mapDemoMethod(){
        map<integer,string> intTostring=new Map<integer,string> ();
        intTostring.put(1,'Prashant');
        intTostring.put(2,'Ayushi');
        system.debug('intTostring::'+intTostring);
        //intTostring.remove(2);
        system.debug('intTostring::'+intTostring);
        list<string> strlist= new list<string> ();
        strlist=intTostring.values();
        system.debug('intTostring::'+strlist);
        set<integer> idset= new set<integer> ();
        idset= intTostring.keyset();
        system.debug('intTostring::'+idset);
        
    }
    public static void mapExample(){
        List<Contact> conlist=[Select id,name,AccountId,Account.Name From Contact Limit 5];
        Map<id,Contact> accountTocontact= new Map<Id,Contact>() ;
        for(Contact con : conlist){
            accountTocontact.put(con.AccountId,con);
            system.debug('accountTocontact::'+accountTocontact);
            
        }
    }
    public static void mapExample1(){
        List<Contact> conlist1=[Select id,name,AccountId From Contact Limit 5];
        Map<Id, List<Contact>> accountContactsMap = new Map<Id, List<Contact>>();
        
        for (Contact c :conlist1 ) {
            if (!accountContactsMap.containsKey(c.AccountId)) {
                accountContactsMap.put(c.AccountId, new List<Contact>{c});
            } else {
                accountContactsMap.get(c.AccountId).add(c);
                system.debug('accountContactsMap::'+accountContactsMap);
                
                }
            for(List<Contact> c1:accountContactsMap.values()){
                    system.debug(c1);
            }
        }
    }
    
    
}