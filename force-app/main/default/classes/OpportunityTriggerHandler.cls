/**
 * @description       :
 * @author            : Deepak
 * @group             :
 * @last modified on  : 01-25-2026
 **/
public with sharing class OpportunityTriggerHandler {
	/**
	 * @description
	 * @author Deepak
	 * @param oppList
	 **/
	public static void restrictClosedOppUpdate(List<Opportunity> oppList, Map<Id, Opportunity> oldOppMap) {
		for (opportunity opp : oppList) {
			if (oldOppMap.get(opp.Id).isClosed && opp != oldOppMap.get(opp.Id)) {
				opp.addError('Cannot update Closed Opportunities');
			}
		}
	}

	/**
	 * @description
	 * @author Deepak | 11-02-2024
	 **/
	public static void validateInsert(List<opportunity> opportunities) {
		for (opportunity opp : opportunities) {
			if ('Closed Won'.equalsIgnoreCase(opp.StageName) && string.isNotBlank(opp.Description)) {
				opp.Description.addError('Description should not be empty for Closed Won opportunity.');
			}
		}
	}

	/**
	 * @description
	 * @author Deepak | 05-25-2025
	 **/
	public static void populateAcctName(List<Opportunity> opportunities) {
		set<Id> acctIds = new Set<Id>();
		Map<Id, Account> acctMap = new Map<Id, Account>();
		for (Opportunity oppt : opportunities) {
			if (oppt.AccountId != null) {
				acctIds.add(Oppt.AccountId);
			}
		}

		if (!acctIds.isEmpty()) {
			acctMap = new Map<Id, Account>([SELECT Id, Name FROM Account WHERE Id IN :acctIds]);
		}

		for (Opportunity opp : opportunities) {
			opp.Name = opp.CloseDate.year() + ' ' + acctMap.get(opp.AccountId).Name + ' Opportunity';
		}
	}

	/**
	 * @description
	 * @author Deepak | 05-25-2025
	 **/
	public static void createRenewalOpportunity(List<Opportunity> newOppt, Map<Id, Opportunity> oldOpptMap) {
		List<Opportunity> oppts = new List<Opportunity>();
		for (Opportunity oppt : newOppt) {
			if ('Closed Won'.equalsIgnoreCase(oppt.StageName)) {
				oppts.add(new Opportunity(AccountId = oppt.AccountId, OwnerId = oppt.OwnerId, stageName = 'Prospecting', CloseDate = Date.Today().addMonths(12)));
			}
		}

		if (!oppts.isEmpty()) {
			Database.insert(oppts);
		}
	}

	/**
	 * @description
	 * @author Deepak | 09-20-2025
	 * @param List<Opportunity> newOpps
	 * @param Map<Id Opportunity> oldOpps
	 **/
	public static void updateAccountRatingHot(List<Opportunity> newOpps, Map<Id, Opportunity> oldOpps) {
		List<Account> hotAccts = new List<Account>();
		for (Opportunity opp : newOpps) {
			if (opp.StageName == 'Closed Won' && (oldOpps == null || (oldOpps != null && opp.StageName != oldOpps.get(opp.Id).StageName))) {
				hotAccts.add(new Account(Id = opp.AccountId, Rating = 'Hot'));
			}
		}

		if (!hotAccts.isEmpty()) {
			Database.update(hotAccts);
		}
	}

	/**
	* @description : Create Task for High Value Opportunity
	* @author Deepak | 01-25-2026 
	* @param List<Opportunity> newOpps 
	**/
	public static void createHighValueOpptTask(List<Opportunity> newOpps){
		set<Id> accIds = new set<Id>();
		List<Opportunity> highValueOpps = new List<Opportunity>();
		for(Opportunity oppt : newOpps) {
			if(Oppt.accountId!= null && ApexConstants.OPPT_PROSPECT.equalsIgnoreCase(oppt.StageName)) {
				accIds.add(oppt.accountId);
				highValueOpps.add(oppt);
			}
		}

		if(!accIds.isEmpty() && !highValueOpps.isEmpty()){
			Map<Id,Account> accMap = new Map<Id,Account>([Select Id,Owner.Name from Account Where Id IN :accIds]);
			List<Task> highValueTasks = new List<Task>();

			for(Opportunity oppt : highValueOpps) {
				Task opptTask = new Task(
					OwnerId = accMap.get(oppt.AccountId)?.OwnerId,
					Subject = 'Follow up Task  - '+ oppt.Name,
					WhatId = oppt.Id,
					ActivityDate = System.Today().addDays(10)
				);
				highValueTasks.add(OpptTask);
			}

			if(!highValueTasks.isEmpty()) {
				Database.insert(highValueTasks);
			}
		}
	}
}