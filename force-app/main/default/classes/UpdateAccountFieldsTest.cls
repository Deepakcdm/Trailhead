@isTest
public class UpdateAccountFieldsTest {

    @isTest
    static void testUpdateAccountFieldsBatch() {
        // Create test data
        Account acc = new Account(Name = 'Test Account', BillingCity = 'New York', BillingCountry = 'USA');
        insert acc;

        Contact con1 = new Contact(FirstName = 'John', LastName = 'Doe', AccountId = acc.Id);
        Contact con2 = new Contact(FirstName = 'Jane', LastName = 'Smith', AccountId = acc.Id);
        insert new List<Contact>{con1, con2};

        // Verify initial state
        List<Contact> contactsBefore = [SELECT MailingCity, MailingCountry FROM Contact WHERE AccountId = :acc.Id];
        for (Contact con : contactsBefore) {
            System.assertEquals(null, con.MailingCity, 'MailingCity should initially be null.');
            System.assertEquals(null, con.MailingCountry, 'MailingCountry should initially be null.');
        }

        // Execute the batch
        Test.startTest();
        UpdateAccountFields batch = new UpdateAccountFields();
        Database.executeBatch(batch);
        Test.stopTest();

        // Verify updated state
        List<Contact> contactsAfter = [SELECT MailingCity, MailingCountry FROM Contact WHERE AccountId = :acc.Id];
        for (Contact con : contactsAfter) {
            System.assertEquals('New York', con.MailingCity, 'MailingCity should be updated to match BillingCity.');
            System.assertEquals('USA', con.MailingCountry, 'MailingCountry should be updated to match BillingCountry.');
        }
    }
}