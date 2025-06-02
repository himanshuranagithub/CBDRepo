trigger AccountDuplicateTrigger on Account (before insert, before update) {
    Set<String> accountNames = new Set<String>();
    for (Account acc : Trigger.new) {
        if (acc.Name != null) {
            accountNames.add(acc.Name);
        }
    }
    
    Map<String, Account> existingAccounts = new Map<String, Account>();
    for (Account acc : [SELECT Id, Name FROM Account WHERE Name IN :accountNames]) {
        existingAccounts.put(acc.Name, acc);
    }
    
    for (Account acc : Trigger.new) {
        if (acc.Name != null && existingAccounts.containsKey(acc.Name)) {
            acc.addError('An account with this name already exists.');
        }
    }
}