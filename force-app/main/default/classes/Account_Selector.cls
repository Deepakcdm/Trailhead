/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 09-07-2025
 * @last modified by  : Deepak
**/
public with sharing class Account_Selector {

    /**
    * @description 
    * @author Deepak | 09-07-2025 
    * @return AcctOpportunityWrapper 
    **/
    public static List<AcctOpportunityWrapper> getAccountOpportunities(){
        List<AcctOpportunityWrapper> acctOpptWrapper = new List<AcctOpportunityWrapper>();

        List<AggregateResult> aggregateResults = [Select AccountId, Account.Name, Count(Id)opptCount, SUM(Amount)opptAmount from Opportunity GROUP By AccountId,Account.Name];

        for(AggregateResult ar : aggregateResults){
            acctOpptWrapper.add(new AcctOpportunityWrapper((String)ar.get('Name'), (Integer)ar.get('opptCount'), (Decimal)ar.get('opptAmount')
            ));
        }
        return acctOpptWrapper;
    }
}