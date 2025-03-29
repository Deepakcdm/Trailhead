/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 03-29-2025
 * @last modified by  : Deepak
**/
trigger CampSponsorTrigger on CAMPX__Sponsor__c (before insert, before update,after insert, after update) {
    if(trigger.isBefore  && trigger.isInsert){
        CampSponsor_TriggerHandler.updateSponsorPendingStatus(trigger.New);
        CampSponsor_TriggerHandler.restrictSponsorWithoutEmail(trigger.New);
        CampSponsor_TriggerHandler.updateSponsorShipTier(trigger.New);
        CampSponsor_TriggerHandler.restrictSponsorWithoutEvent(Trigger.new,null);
     }
     if(trigger.isBefore && trigger.isUpdate){
        CampSponsor_TriggerHandler.restrictSponsorWithoutEvent(Trigger.new, Trigger.oldMap);
    }
    if(trigger.isAfter && trigger.isInsert){
        CampSponsor_TriggerHandler.updateEventGrossRevenue(Trigger.new, null);
    }
    if(trigger.isAfter && trigger.isUpdate){
        CampSponsor_TriggerHandler.updateEventGrossRevenue(Trigger.new, Trigger.oldMap);
    }
}