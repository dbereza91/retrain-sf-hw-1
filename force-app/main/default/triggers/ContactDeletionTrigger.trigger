trigger ContactDeletionTrigger on Contact (after delete) {
    List<ContactRemovalHistory__c> histories = new List<ContactRemovalHistory__c>();
    for (Contact c: Trigger.old) {
        if (c.email != null) {
            ContactRemovalHistory__c history = new ContactRemovalHistory__c(ContactEmail__c=c.email);
            histories.add(history);
        }
    }
    insert histories;
}