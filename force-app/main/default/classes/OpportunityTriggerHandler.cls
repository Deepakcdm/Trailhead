public without sharing class OpportunityTriggerHandler {
    
    public static void closeDateBefore(List<Opportunity>oppList){
        for(opportunity opp:oppList){
            System.debug('The Opportunity Close Date before update is'+opp.CloseDate);
        }
    }

    public static void closeDateAfter(List<Opportunity>oppList){
        for(Opportunity opp:oppList){
            System.debug('The Opportunity Close Date after update is'+opp.CloseDate);
        }
    }
}