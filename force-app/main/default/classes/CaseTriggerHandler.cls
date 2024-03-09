public with sharing class CaseTriggerHandler {
private static final string STR_HYPHEN = '-';
    public static void checkDuplicateCases(List<case>caseList){
        try{
            Map<String,Case>accCaseMap = new Map<String,Case>();
            set<Id>accIds = new set<Id>();
            set<Id>caseIds = new set<Id>();
            for(Case c:CaseList){
                if(c.AccountId!=null && c.Service_Amount__c!=null){
                    if(!accCaseMap.containsKey(c.AccountId+STR_HYPHEN+c.Service_Amount__c)){
                        accCaseMap.put(c.AccountId+STR_HYPHEN+c.Service_Amount__c,c);
                        accIds.add(c.AccountId);
                        caseIds.add(c.Id);
                    }
                    else{
                        c.addError('This is the Duplicate Case');
                    }
                }
            }
            if(!accIds.isEmpty()){
                Map<String,List<Case>>caseMap = new Map<String,List<Case>>();
                for(Case c:[Select Id,AccountId,Service_Amount__c from Case Where AccountId IN:accIds and ID NOT IN :caseIds]){
                        caseMap.put(c.AccountId+STR_HYPHEN+c.Service_Amount__c,new List<Case>{c});
                }

                if(!caseMap.isEmpty()){
                    for(Case c: CaseList){
                        if(caseMap.containskey(c.AccountId+STR_HYPHEN+c.Service_Amount__c)){
                            c.addError('This is a Duplicate Case');
                        }
                    }
                }
            }
        }
        catch(exception exe){
            System.debug(exe.getMessage());
        }
    }

    public static void updateAcctoCaseFields(List<case>caseList,Map<Id,Case>oldCaseMap){
        try{
            set<Id>accIds = new set<Id>();
            Map<Id,List<Case>>caseMap = new Map<Id,List<Case>>();
            List<Account>accList = new List<Account>();
            for(Case c: CaseList){
                if(c.AccountId != null && (oldCaseMap==null || oldCaseMap!=null && c.AccountId!= oldCaseMap.get(c.Id).AccountId)){
                    accIds.add(c.AccountId);
                    accIds.add(oldCaseMap?.get(c.Id).AccountId);
                }
            }

            List<Account>acccaseList = [Select Id,Number_of_Cases__c,Overall_Service_Amount__c,(Select Id,AccountId,Service_Amount__c from Account.Cases) 
            from Account where ID IN:accIds];

            if(!acccaseList.isEmpty()){
                for(Account acct:acccaseList){
                    integer numofcases = 0;
                    decimal serviceamount = 0;
                    for(Case c1:acct.Cases){
                        numofcases = numofcases +1;
                        serviceamount = serviceamount + c1.Service_Amount__c;
                    }
                    acct.Number_of_Cases__c = numofcases;
                    acct.Overall_Service_Amount__c = serviceamount;
                    accList.add(acct);
                }
                Database.update(accList);
            }
        }
        catch(exception exe){
            System.debug(exe.getMessage());
            System.debug(exe.getLineNumber());
        }
    }

}