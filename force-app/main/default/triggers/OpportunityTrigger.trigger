/**
 * @description       : Opportunity Object Trigger
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 05-25-2025
**/
trigger OpportunityTrigger on Opportunity (before insert,before update, after insert, after update) {

    if (Trigger.isBefore && Trigger.isInsert){ 
        OpportunityTriggerHandler.validateInsert(Trigger.new);
        OpportunityTriggerHandler.populateAcctName(Trigger.new);
        OpportunityTriggerHandler.updateAccountRatingHot(Trigger.new,null);
    }

    if(Trigger.isAfter && Trigger.isUpdate){
        OpportunityTriggerHandler.createRenewalOpportunity(Trigger.New, Trigger.oldMap);
        OpportunityTriggerHandler.updateAccountRatingHot(Trigger.new, Trigger.oldMap);
    }
}