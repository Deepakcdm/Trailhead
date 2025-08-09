/**
 * @description       : 
 * @author            : Deepak
 * @Created on        : 07-20-2025
 * @Created by        : Deepak
 * @last modified on  : 07-20-2025
 * @last modified by  : Deepak 
 * Modifications Log
 * Ver   Date         Author   Modification
 * 1.0   07-20-2025   Deepak   Initial Version
**/
public class Solution {
	
    /**
    * @description 
    * @author Deepak | 07-20-2025 
    * @param List<Contact> allContacts 
    * @param List<String> zipCodes 
    * @return Set<Id> 
    **/
    public Set<Id> filterByZipCode(List<Contact> allContacts, List<String> zipCodes) {
	set<Id> conIds = new Set<Id>();

	List<Contact> filteredContacts = [Select Id FROM Contact WHERE Id IN :allContacts AND MailingPostalCode IN :zipCodes];
	if (!filteredContacts.isEmpty()) {
		for (Contact filteredContact : filteredContacts) {
			conIds.add(filteredContact.Id);
		}
	}
    return conIds;
}

    /**
    * @description 
    * @author Deepak | 07-20-2025 
    * @param List<Opportunity> oppList 
    * @return Id 
    **/
    public Id getAccountWithHighestTotalOppAmount(List<Opportunity> oppList){
        AggregateResult arResult = [Select SUM(Amount),AccountId from Opportunity Where Id IN :oppList GROUP By AccountId order by SUM(Amount) DESC LIMIT 1];
        System.debug('The AR Result is '+ arResult);
        return (Id) arResult.get('AccountId');
    }
}