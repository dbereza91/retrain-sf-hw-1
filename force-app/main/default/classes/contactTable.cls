public with sharing class contactTable {

    @AuraEnabled(cacheable = true)
    public static  List<ContactWrapper> fetchContacts() {
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
    public static void deleteContacts(List<Id> accountIds){
        delete [SELECT Id FROM Contact where id in :accountIds];
    }


    class ContactWrapper{

        @AuraEnabled public Id contactId {get; set;}
        @AuraEnabled public String name {get; set;}
        @AuraEnabled public String email {get; set;}
        @AuraEnabled public String accountName {get; set;}
    
    }

}
