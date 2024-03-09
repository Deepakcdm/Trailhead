public with sharing class AuraController {

    @AuraEnabled
    public static void closeAccountCases(string accId){
        try {
            List<Case>caseList = new List<Case>();
            List<Case>openCases = [Select Id,Status,AccountId from Case where Status!='Closed' and AccountId =:accId];
            if(!openCases.isEmpty()){
                for(Case c : openCases){
                    c.Status='Closed';
                    caseList.add(c);
                }
                Database.update(caseList);
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}