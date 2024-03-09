/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 03-09-2024
**/
public with sharing class OpportunityTriggerHandler {
    
    /**
    * @description 
    * @author Deepak
    * @param oppList 
    **/
    public static void restrictClosedOppUpdate(List<Opportunity> oppList, Map<Id,Opportunity> oldOppMap){
        for(opportunity opp:oppList){
            if(oldOppMap.get(opp.Id).isClosed && opp != oldOppMap.get(opp.Id)){
                opp.addError('Cannot update Closed Opportunities');
            }
        }
    }
}