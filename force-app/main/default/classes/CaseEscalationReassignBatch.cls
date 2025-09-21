/**
 * @description       :
 * @author            : Deepak
 * @Created on        : 09-20-2025
 * @Created by        : Deepak
 * @last modified on  : 09-20-2025
 * @last modified by  : Deepak
 * Modifications Log
 * Ver   Date         Author   Modification
 * 1.0   09-20-2025   Deepak   Initial Version
 **/
public without sharing class CaseEscalationReassignBatch implements Schedulable, Database.Batchable<sObject> {
	string billingQueueId = [SELECT Id FROM Group WHERE DeveloperName = 'Billing_Support_Agents' AND Type = 'Queue' LIMIT 1].Id;
	string caseClosedStatus = ApexConstants.CASE_CLOSED;

    /**
    * @description 
    * @author Deepak | 09-20-2025 
    * @param SchedulableContext SC 
    **/
    public  void execute(SchedulableContext SC) {
      CaseEscalationReassignBatch caseReassignBatch = new CaseEscalationReassignBatch(); 
   }

	/**
	 * @description
	 * @author Deepak | 09-20-2025
	 * @param Database.BatchableContext bc
	 * @return Database.QueryLocator
	 **/
	public Database.QueryLocator start(Database.BatchableContext bc) {
		String query;
		if(!Test.isRunningTest()){
			query = 'Select Id from Case Where Status!= :caseClosedStatus AND LastModifiedDate <= LAST_90_DAYS';
		}else{
			query = 'Select Id from Case Where Status!= :caseClosedStatus AND LastModifiedDate=TODAY';
		}
		return Database.getQueryLocator(query);
	}

	/**
	 * @description
	 * @author Deepak | 09-20-2025
	 * @param Database.BatchableContext BC
	 * @param List<SObject> scope
	 **/
	public void execute(Database.BatchableContext BC, List<Case> scope) {
		List<Case> openCases = new List<Case>();
		for (Case openCase : scope) {
			openCases.add(new Case(Id = openCase.Id, OwnerId = billingQueueId));
		}
		Database.update(openCases);
	}

    /**
    * @description 
    * @author Deepak | 09-20-2025 
    * @param Database.BatchableContext bc 
    **/
    public void finish(Database.BatchableContext bc){

   }
}