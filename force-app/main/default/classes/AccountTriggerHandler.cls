/**
 * @description       :
 * @author            : Deepak Kumar
 * @group             :
 * @Created on  : 03-09-2024
 **/
public with sharing class AccountTriggerHandler {
	/**
	 * @description : Map the Changes of Billing Address to Shipping Address
	 * @author Deepak Kumar | 03-09-2024
	 **/
	public static void copyShippingAddress(List<Account> newAccts, Map<Id, Account> oldAccMap) {
		try {
			for (Account acct : newAccts) {
				Boolean billingStreetChanged = (acct.BillingStreet != oldAccMap.get(acct.Id)?.BillingStreet ? true : false);
				Boolean billingCityChanged = (acct.BillingCity != oldAccMap.get(acct.Id)?.BillingCity ? true : false);
				Boolean billingStateChanged = (acct.BillingState != oldAccMap.get(acct.Id)?.BillingState ? true : false);
				Boolean billingCountryChanged = (acct.BillingCountry != oldAccMap.get(acct.Id)?.BillingCountry ? true : false);
				Boolean billingPostalCodeChanged = (acct.BillingPostalCode != oldAccMap.get(acct.Id)?.BillingPostalCode ? true : false);

				if (billingStreetChanged || billingCityChanged || billingStateChanged || billingCountryChanged || billingPostalCodeChanged) {
					acct.ShippingStreet = oldAccMap.get(acct.Id)?.BillingStreet;
					acct.ShippingCity = oldAccMap.get(acct.Id)?.BillingCity;
					acct.ShippingState = oldAccMap.get(acct.Id)?.BillingState;
					acct.ShippingCountry = oldAccMap.get(acct.Id)?.BillingCountry;
					acct.ShippingPostalCode = oldAccMap.get(acct.Id)?.BillingPostalCode;
				}
			}
		} catch (exception e) {
			system.debug('There is an Error' + e.getMessage());
		}
	}

	/**
	 * @description
	 * @author Deepak Kumar | 03-09-2024
	 **/
	public static void restrictDuplicateAccounts(List<Account> newAccts) {
		try {
			Map<String, List<Account>> newacctsMap = new Map<String, List<Account>>();
			for (Account acct : newAccts) {
				if (!newacctsMap.containsKey(acct.Name)) {
					newacctsMap.put(acct.Name, new List<Account>());
				} else {
					newacctsMap.get(acct.Name).add(acct);
				}
			}

			Map<String, Account> existingAcctsMap = new Map<String, Account>();
			for (Account acct : [SELECT Id, Name FROM Account WHERE Name IN :newacctsMap.keySet()]) {
				existingAcctsMap.put(acct.Name, acct);
			}

			for (Account acc : newAccts) {
				if ((newacctsMap.containsKey(acc.Name) && newacctsMap.get(acc.Name)?.size() > 1) || existingAcctsMap.containsKey(acc.Name)) {
					acc.addError('This Account is Duplicate. There is another Account with Same Name');
				}
			}
		} catch (exception e) {
			system.debug(e.getMessage());
		}
	}

	/**
	 * @description : Restrict the Creaton of Accounts by Non-Admin Users
	 * @author Deepak Kumar | 03-09-2024
	 **/
	public static void restrictNonAdminAccCreate(List<Account> newAccts) {
		try {
			String currentProfileName = [SELECT Id, Name FROM Profile WHERE Id = :UserInfo.getProfileId()]?.Name;
			if (currentProfileName != 'System Administrator') {
				for (Account acct : newAccts) {
					acct.addError('No Non-Admin Profiles are allowed to create an Account');
				}
			}
		} catch (exception e) {
			system.debug(e.getMessage());
		}
	}

	/**
	 * @description : Restrict the Deletion of Accounts which has more than 2 Contacts
	 * @author Deepak Kumar | 03-09-2024
	 **/
	public static void restrictAccWithTwoContacts(Map<Id, Account> acctsMap) {
		try {
			Map<Id, Account> acctContactMap = new Map<Id, Account>([SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :acctsMap.keySet()]);
			for (Account acct : acctsMap.values()) {
				if (acctContactMap.containskey(acct.Id) && acctContactMap.get(acct.Id)?.Contacts != null && acctContactMap.get(acct.Id)?.Contacts?.size() > 2) {
					acct.addError('You cannot delete the Account with more than 2 Child Contacts');
				}
			}
		} catch (exception e) {
			system.debug(e.getMessage());
		}
	}

	/**
	 * @description : Restrict the Deletion of Accounts which has atleast one Contact
	 * @author Deepak Kumar | 03-09-2024
	 **/
	public static void restrictAccWithContacts(Map<Id, Account> acctsMap) {
		try {
			Map<Id, Account> acctContactMap = new Map<Id, Account>([SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :acctsMap.keySet()]);
			for (Account acct : acctsMap.values()) {
				if (acctContactMap.containskey(acct.Id) && acctContactMap.get(acct.Id)?.Contacts != null && acctContactMap.get(acct.Id)?.Contacts?.size() > 0) {
					acct.addError('You cannot delete the Account with Child Contacts');
				}
			}
		} catch (exception e) {
			system.debug(e.getMessage());
		}
	}

	/**
	 * @description : Restrict the Deletion of Account which is being Child of another Parent Account
	 * @author Deepak Kumar | 03-09-2024
	 **/
	public static void restrictAccwithParentAcc(Map<Id, Account> oldAccMap) {
		try {
			for (Account acct : oldAccMap.values()) {
				if (acct.parentId != null) {
					acct.addError('You cannot delete Accounts associated with Parent Account');
				}
			}
		} catch (exception e) {
			system.debug(e.getMessage());
		}
	}

	/**
	 * @description
	 * @author Deepak | 04-09-2025
	 * @param List<Account> newAccts
	 **/
	public static void populateRating(List<Account> newAccts) {
		for (Account acc : newAccts) {
			acc.Active__c = 'Yes';
		}
	}

	/**
	 * @description : Set Created Date to Today for all Accounts
	 * @author Deepak Kumar | 04-09-2024
	 **/
	public static void setCreatedDate(List<Account> newAccts) {
		for (Account acct : newAccts) {
			acct.CreatedDate = System.now().addDays(-100);
		}
	}

	/**
	 * @description
	 * @author Deepak | 08-03-2025
	 * @param List<Account> newAccts
	 * @param Map<Id Account> oldAcctMap
	 **/
	public static void checkFormulaFieldChange(List<Account> newAccts, Map<Id, Account> oldAcctMap) {
		for (Account acct : newAccts) {
			if (oldacctMap == null || (acct.RecordType_Name__c != oldAcctMap.get(acct.Id)?.RecordType_Name__c)) {
				System.debug('The New Account Record Type Name is ' + acct.RecordType_Name__c);
				System.debug('The Old Account Record Type Name is ' + oldAcctMap?.get(acct.Id)?.RecordType_Name__c);
			}
		}
	}

	/**
	 * @description
	 * @author Deepak | 08-09-2025
	 * @param List<Account> accts
	 **/
	public static void updateAcctStatusAsync(List<Account> accts) {
		if (!accts.isEmpty()) {
			System.enqueueJob(new AccountCreateQueueable(accts));
		}
	}

	/**
	 * @description
	 * @author Deepak | 08-31-2025
	 * @param List<Account> accts
	 **/
	public static void UpdateDescription(List<Account> accts) {
		for (Account acct : accts) {
			if (string.isBlank(acct.Description) || acct.Description == null) {
				acct.Description = 'No Description Provided';
			}
		}
	}

	/**
	 * @description
	 * @author Deepak | 09-07-2025
	 * @param String accName
	 * @param String accPhone
	 **/
	public static Id createAccount(String accName, String accPhone) {
		Account acct = new Account(Name = accName, phone = accPhone);
		insert acct;
		return acct.Id;
	}

	/**
	 * @description
	 * @author Deepak | 09-07-2025
	 * @return List<Account>
	 **/
	public static List<Account> getTechnologyAccounts() {
		return [SELECT Id, Name FROM Account WHERE Industry = 'Technology'];
	}

	/**
	 * @description
	 * @author Deepak | 09-07-2025
	 **/
	public static void createContact(List<Account> accts) {
		List<Contact> contacts = new List<Contact>();
		for (Account acct : accts) {
			contacts.add(new Contact(AccountId = acct.Id, LastName = acct.Name));
		}

		if (!contacts.isEmpty()) {
			Database.insert(contacts);
		}
	}
}