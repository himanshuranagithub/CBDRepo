public class Accountdetail {
    @AuraEnabled(cacheable=true)
    public static List<Account> fetchAccounts() {
        List<Account> acc = [SELECT Id, Name, Phone, Email__c FROM Account LIMIT 20];
        system.debug(acc);
        return acc;
    }

    @AuraEnabled
public static String sendEmails(List<Id> accountIds) {
    List<String> emailAddresses = new List<String>();
    
    // Fetch email addresses of selected accounts
    for (Account acc : [SELECT Id, Email__c FROM Account WHERE Id IN :accountIds]) {
        emailAddresses.add(acc.Email__c);
        system.debug(emailAddresses);
    }

    if (emailAddresses.isEmpty()) {
        return 'No email addresses to send to.';
    }

    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
    email.setToAddresses(emailAddresses);
    email.setSubject('welcome email');
    email.setPlainTextBody('A warm welcome and lots of good wishes on becoming part of our growing team. Congratulations and on behalf of all the members. We are all happy and excited about your input and contribution to our company.');

    Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
    
    if (results[0].isSuccess()) {
        return 'Email sent successfully';
    } else {
        return 'Error sending email: ' + results[0].getErrors()[0].getMessage();
    }
}
  @AuraEnabled(cacheable=true)
 public static List<Account> getAccounts() {
        return [SELECT Id, Name, email__c, phone FROM Account];
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
        return [SELECT Id, Name, Email,  Account.Name FROM Contact  LIMIT 10];
    }

@AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(String searchKey) {
        String searchQuery = '%' + searchKey + '%';
        return [SELECT Id, Name, Industry, Type FROM Account WHERE Name LIKE :searchQuery];
    }
 @AuraEnabled(cacheable=true)
    public static List<Contact> fetchContactsByAccountId(List<Id> selectedIds) {
        return [SELECT Id, Name, Email,Account.Name  FROM Contact WHERE AccountId = :selectedIds];
    }

@AuraEnabled
public static void deleteAccounts(List<Id> accountIds) {
    system.debug('accountid@@'+ accountIds);
    List<Account> accountsToDelete = new List<Account>();
    accountsToDelete = [SELECT Id FROM Account WHERE Id IN :accountIds];
    system.debug('accountstodelete@@@' +accountsToDelete);
    if (!accountsToDelete.isEmpty()) {
     
        delete accountsToDelete;
    }
}

}