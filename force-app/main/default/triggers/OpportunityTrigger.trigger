/**
 * @description       : Opportunity Object Trigger
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 03-11-2024
**/
trigger OpportunityTrigger on Opportunity (before update) {

    if(trigger.isBefore && trigger.isUpdate){
        OpportunityTriggerHandler.restrictClosedOppUpdate(Trigger.new, Trigger.OldMap);
    }

}