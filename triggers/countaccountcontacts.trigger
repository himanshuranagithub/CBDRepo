trigger countaccountcontacts on Contact (after insert) {
    CountContactHandler.countcontactonaccount(Trigger.new);
}