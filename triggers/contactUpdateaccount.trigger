trigger contactUpdateaccount on Contact (after insert,after update) {
    contactUpdateAccountClass.contactUpdateAccountMethod(trigger.new);

}