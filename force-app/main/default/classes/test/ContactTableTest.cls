@isTest
public class ContactTableTest {
    
	@isTest static void fetchContacts() {
        Contact contact = new Contact(Email = 'valera_meladze@gmail.com', LastName='Meladze');
        insert contact;
        System.assertEquals(1, contactTable.fetchContacts().size());
    }

    @isTest static void deleteContacts() {
        Contact contact = new Contact(Email = 'valera_meladze@gmail.com', LastName='Meladze');
        insert contact;
        System.assertEquals(1, contactTable.fetchContacts().size());
        List<Id> ids = new List<Id>();
        ids.add(contact.Id);
        contactTable.deleteContacts(ids);
        System.assertEquals(0, contactTable.fetchContacts().size());
    }

}
