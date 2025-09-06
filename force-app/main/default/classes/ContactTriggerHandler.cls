/**
 * @description       :
 * @author            : Deepak
 * @group             :
 * @last modified on  : 08-31-2025
 * @last modified by  : Deepak
 **/
public without sharing class ContactTriggerHandler {
	/**
	 * @description
	 * @author Deepak | 05-18-2025
	 * @param List<Contact> conList
	 **/
	public static void updateContactsCount(List<Contact> conList) {
		Set<id> accIds = new Set<Id>();
		Map<Id, List<Contact>> accConMap = new Map<Id, List<Contact>>();
		List<Account> accList = new List<Account>();
		for (Contact con : conList) {
			accIds.add(con.AccountId);
		}

		for (Contact cont : [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accIds]) {
			if (!accConMap.containsKey(cont.AccountId)) {
				accConMap.put(cont.AccountId, new List<Contact>{ cont });
			} else {
				accConMap.get(cont.AccountId).add(cont);
			}
		}

		for (Account acc : [SELECT Id, Number_of_Contacts__c FROM Account WHERE Id IN :accConMap.keyset()]) {
			if (accConMap.containskey(acc.Id)) {
				acc.Number_of_Contacts__c = accConMap.get(acc.Id).size();
			}
		}
		update accList;
	}

    /**
    * @description 
    * @author Deepak | 08-31-2025 
    **/
    public static void updateBirthDate(List<Contact> newContacts, Map<Id,Contact> oldConMap){
        for(Contact cont : newContacts){
            if(cont.BirthDate!=null && cont.BirthDate!= oldConMap.get(cont.Id).Birthdate && cont.BirthDate > System.Today()){
                cont.BirthDate = Date.newInstance(2000,01,01);
            }
        }
    }
}