@isTest(SeeAllData=true)
private class AccountTriggerTest {
	@isTest
	static void testRestrictNonAdminAccCreate() {
		User adminUser = [SELECT Id FROM User WHERE Profile.Name = 'System Administrator' LIMIT 1];
		System.runAs(adminUser) {
			Account acc = new Account(Name = 'Test Account');
			Test.startTest();
			insert acc;
			Test.stopTest();
			System.assertNotEquals(null, acc.Id, 'Admin should be able to create an account.');
		}

		User nonAdminUser = [SELECT Id FROM User WHERE Profile.Name != 'System Administrator' LIMIT 1];
		System.runAs(nonAdminUser) {
			Account acc = new Account(Name = 'Test Account');
			Test.startTest();
			try {
				insert acc;
				System.assert(false, 'Non-admin user should not be able to create an account.');
			} catch (DmlException e) {
				System.assert(e.getMessage().contains('You are not authorized'), 'Expected authorization error.');
			}
			Test.stopTest();
		}
	}

	@isTest
	static void testRestrictDuplicateAccounts() {
		Account acc1 = new Account(Name = 'Duplicate Account');
		insert acc1;

		Account acc2 = new Account(Name = 'Duplicate Account');
		Test.startTest();
		try {
			insert acc2;
			System.assert(false, 'Duplicate accounts should not be allowed.');
		} catch (DmlException e) {
			System.assert(e.getMessage().contains('Duplicate Account'), 'Expected duplicate account error.');
		}
		Test.stopTest();
	}

	@isTest
	static void testPopulateRating() {
		Account acc = new Account(Name = 'Test Account');
		Test.startTest();
		insert acc;
		Test.stopTest();
		acc = [SELECT Rating FROM Account WHERE Id = :acc.Id];
		System.assertNotEquals(null, acc.Rating, 'Rating should be populated after insert.');
	}

	@isTest
	static void testRestrictAccWithTwoContacts() {
		Account acc = new Account(Name = 'Test Account');
		insert acc;

		Contact contact1 = new Contact(FirstName = 'John', LastName = 'Doe', AccountId = acc.Id);
		Contact contact2 = new Contact(FirstName = 'Jane', LastName = 'Doe', AccountId = acc.Id);
		insert new List<Contact>{ contact1, contact2 };

		Test.startTest();
		try {
			delete acc;
			System.assert(false, 'Account with two contacts should not be deletable.');
		} catch (DmlException e) {
			System.assert(e.getMessage().contains('Cannot delete account with two contacts'), 'Expected error for account with two contacts.');
		}
		Test.stopTest();
	}

	@isTest
	static void testRestrictAccWithContacts() {
		Account acc = new Account(Name = 'Test Account');
		insert acc;

		Contact contact = new Contact(FirstName = 'John', LastName = 'Doe', AccountId = acc.Id);
		insert contact;

		Test.startTest();
		try {
			delete acc;
			System.assert(false, 'Account with contacts should not be deletable.');
		} catch (DmlException e) {
			System.assert(e.getMessage().contains('Cannot delete account with contacts'), 'Expected error for account with contacts.');
		}
		Test.stopTest();
	}

	@isTest
	static void testRestrictAccWithParentAcc() {
		Account parentAcc = new Account(Name = 'Parent Account');
		insert parentAcc;

		Account childAcc = new Account(Name = 'Child Account', ParentId = parentAcc.Id);
		insert childAcc;

		Test.startTest();
		try {
			delete parentAcc;
			System.assert(false, 'Parent account with child accounts should not be deletable.');
		} catch (DmlException e) {
			System.assert(e.getMessage().contains('Cannot delete parent account'), 'Expected error for parent account with child accounts.');
		}
		Test.stopTest();
	}

	@isTest
	static void testCopyShippingAddress() {
		Account acc = new Account(
			Name = 'Test Account',
			ShippingStreet = '123 Test St',
			ShippingCity = 'Test City',
			ShippingState = 'TS',
			ShippingPostalCode = '12345',
			ShippingCountry = 'Testland'
		);
		insert acc;

		acc.BillingStreet = '456 Billing St';
		acc.BillingCity = 'Billing City';
		acc.BillingState = 'BC';
		acc.BillingPostalCode = '67890';
		acc.BillingCountry = 'Billingland';

		Test.startTest();
		update acc;
		Test.stopTest();

		acc = [SELECT BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry FROM Account WHERE Id = :acc.Id];
		System.assertEquals('123 Test St', acc.BillingStreet, 'BillingStreet should match ShippingStreet.');
		System.assertEquals('Test City', acc.BillingCity, 'BillingCity should match ShippingCity.');
		System.assertEquals('TS', acc.BillingState, 'BillingState should match ShippingState.');
		System.assertEquals('12345', acc.BillingPostalCode, 'BillingPostalCode should match ShippingPostalCode.');
		System.assertEquals('Testland', acc.BillingCountry, 'BillingCountry should match ShippingCountry.');
	}
}