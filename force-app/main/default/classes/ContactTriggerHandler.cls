/**
 * @description       :
 * @author            : Deepak
 * @group             :
 * @last modified on  : 09-07-2025
 * @last modified by  : Deepak
 **/
public without sharing class ContactTriggerHandler {
	/**
	 * @description
	 * @author Deepak | 08-31-2025
	 **/
	public static void updateBirthDate(List<Contact> newContacts, Map<Id, Contact> oldConMap) {
		for (Contact cont : newContacts) {
			if (cont.BirthDate != null && cont.BirthDate != oldConMap.get(cont.Id).Birthdate && cont.BirthDate > System.Today()) {
				cont.BirthDate = Date.newInstance(2000, 1, 1);
			}
		}
	}

	/**
	 * @description
	 * @author Deepak | 09-07-2025
	 * @param List<Contact> newContacts
	 **/
	public static void updateContactsCount(List<Contact> newContacts, Map<Id, Contact> oldContactMap) {
		set<Id> acctIds = new Set<Id>();

		if (newContacts != null) {
			for (Contact con : newContacts) {
				if (con.AccountId != null) {
					acctIds.add(con.AccountId);
				}
			}
		}

		if (oldContactMap != null) {
			for (Contact cont : oldContactMap.Values()) {
				if (cont.accountId != null) {
					acctIds.add(cont.AccountId);
				}
			}
		}

		if (!acctIds.isEmpty()) {
			List<AggregateResult> aggregateResults = [SELECT AccountId, Count(Id) contactsCount FROM Contact WHERE AccountId IN :acctIds GROUP BY AccountId];

			List<Account> accts = new List<Account>();
			for (aggregateResult ar : aggregateResults) {
				accts.add(new Account(Id = (Id) ar.get('AccountId'), Number_Of_Contacts__c = (Integer) ar.get('contactsCount')));
			}
			Database.update(accts);
		}
	}

	/**
	* @description 
	* @author Deepak | 09-20-2025 
	* @param List<Contact> newContacts 
	* @param Map<Id Contact> oldContacts 
	**/
	public static void restrictDuplicateContacts(List<Contact> newContacts, Map<Id,Contact> oldContacts){
		Map<Id, List<String>> accConMap = new Map<Id, List<String>>();

		for(Contact con : newContacts){
			if(String.isNotBlank(con.Email) && (oldContacts==null || (oldContacts!=null && con.Email!= oldContacts.get(con.Id).Email))){
				if(!accConMap.containskey(con.AccountId)){
					accConMap.put(con.AccountId, new List<String>{con.Email});
				}else{
					accConMap.get(con.AccountId).add(con.Email);
				}
			}
		}

		if(!accConMap.isEmpty()){
			for(Contact con : [Select Id,AccountId, Email from Contact Where AccountId IN :accConMap.keySet()]){
				if(!accConMap.containskey(con.AccountId)){
					accConMap.put(con.AccountId, new List<String>{con.Email});
				}else{
					accConMap.get(con.AccountId).add(con.Email);
				}
			}
		}

		for(Contact con : newContacts){
			if(accConMap.containskey(con.AccountId) && accConMap.get(con.AccountId).size() > 1){
				con.addError('Duplicate Email Exist for the Contact - ' + con.Email);
			}
		}
	}
}