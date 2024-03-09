public without sharing class ContactTriggerHandler {

    public static void updateContactsCount(List<Contact>conList){
        Set<id>accIds = new set<Id>();
        Map<Id,List<Contact>>accConMap = new Map<Id,List<Contact>>();
        List<Account>accList = new List<Account>();
        for(Contact con:conList){
            accIds.add(con.AccountId);
        }

        for(Contact cont:[Select Id,AccountId from Contact where AccountId IN:accIds]){
            if(!accConMap.containsKey(cont.AccountId)){
                accConMap.put(cont.AccountId,new List<Contact>{cont});
            }
            else{
                accConMap.get(cont.AccountId).add(cont);
            }
        }

        for(Account acc:[Select Id,Number_of_Contacts__c from Account where Id IN:accConMap.keyset()]){
            if(accConMap.containskey(acc.Id)){
                acc.Number_of_Contacts__c=accConMap.get(acc.Id).size();
            }
        }
        update accList;
    }
}