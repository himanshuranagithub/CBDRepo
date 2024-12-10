trigger ContactChangeEventTrigger on ContactChangeEvent (after insert) {
    
    for (ContactChangeEvent event : Trigger.new) {
        Id contactId = event.Id;
        String newEmail = event.Email;

        // Query the contact
        Contact contactToUpdate = [SELECT Id, Email FROM Contact WHERE Id = :contactId LIMIT 1];

        if (contactToUpdate != null) {
            // Update email address
            contactToUpdate.Email = newEmail;
            update contactToUpdate;
        }
    }
}