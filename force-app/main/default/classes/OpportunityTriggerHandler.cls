/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 05-25-2025
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

    /**
    * @description 
    * @author Deepak | 11-02-2024 
    **/
    public static void validateInsert(List<opportunity> opportunities){
        for(opportunity opp: opportunities){
            if('Closed Won'.equalsIgnoreCase(opp.StageName) && string.isNotBlank(opp.Description)){
                opp.Description.addError('Description should not be empty for Closed Won opportunity.');
            }
        }
    }

    /**
    * @description 
    * @author Deepak | 05-25-2025 
    **/
    public static void populateAcctName(List<Opportunity> opportunities){
        set<Id>acctIds = new set<Id>();
        Map<Id,Account> acctMap = new Map<Id,Account>();
        for(Opportunity oppt: opportunities){
            if(oppt.AccountId!=null){
            acctIds.add(Oppt.AccountId);
            }
        }

        if(!acctIds.isEmpty()){
            acctMap = new Map<Id,Account>([Select Id, Name From Account Where Id in: acctIds]);
        }

        for(Opportunity opp: opportunities){
            opp.Name = opp.CloseDate.year()+' '+acctMap.get(opp.AccountId).Name+' Opportunity';
        }
    }

    /**
    * @description 
    * @author Deepak | 05-25-2025 
    **/
    public static void createRenewalOpportunity(List<Opportunity> newOppt, Map<Id,Opportunity> oldOpptMap){
        List<Opportunity> oppts = new List<Opportunity>();
        for(Opportunity oppt : newOppt){
            if('Closed Won'.equalsIgnoreCase(oppt.StageName)){
                oppts.add(new Opportunity(
                    AccountId=oppt.AccountId,
                    OwnerId=oppt.OwnerId,
                    stageName='Prospecting',
                    CloseDate=Date.Today().addMonths(12))
                );
            }
        }

        if(!oppts.isEmpty()){
            Database.insert(oppts);
        }
    }
}