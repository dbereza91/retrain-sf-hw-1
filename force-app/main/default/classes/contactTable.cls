public with sharing class ContactTable {

    @AuraEnabled(cacheable = true)
    public static List<ContactWrapper> fetchContacts() {
        List<Contact> contacts = [SELECT Name, Email, Account.Name FROM Contact];
        List<ContactWrapper> result = new List<ContactWrapper>();
        for (Contact c: contacts){
            ContactWrapper wrapper = new ContactWrapper();
            wrapper.contactId = c.id;
            wrapper.name = c.name;
            wrapper.email = c.email;
            wrapper.accountName = c.Account.name;
            result.add(wrapper);
        }
        return result;
    }

    @AuraEnabled
    public static void deleteContacts(List<Id> contactIds){
        try {
            List<Contact> contacts = new List<Contact>();
            List<Case> cases = [SELECT Id, contactId FROM Case WHERE contactId in :contactIds];
            delete cases;
            for (Id item: contactIds) {
                contacts.add(new Contact(Id = item));
            }
            delete contacts;
        } catch (DmlException e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


    class ContactWrapper{

        @AuraEnabled public Id contactId {get; set;}
        @AuraEnabled public String name {get; set;}
        @AuraEnabled public String email {get; set;}
        @AuraEnabled public String accountName {get; set;}
    
    }

}