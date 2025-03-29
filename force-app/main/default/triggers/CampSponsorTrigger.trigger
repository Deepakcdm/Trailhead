/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 03-29-2025
 * @last modified by  : Deepak
**/
trigger CampSponsorTrigger on CAMPX__Sponsor__c (before insert, before update) {
    if(trigger.isBefore  && trigger.isInsert){
        CampSponsor_TriggerHandler.updateSponsorPendingStatus(trigger.New);
        CampSponsor_TriggerHandler.restrictSponsorWithoutEmail(trigger.New);
        CampSponsor_TriggerHandler.updateSponsorShipTier(trigger.New);
        CampSponsor_TriggerHandler.restrictSponsorWithoutEvent(Trigger.new,null);
     }else if(trigger.isBefore && trigger.isUpdate){
        CampSponsor_TriggerHandler.restrictSponsorWithoutEvent(Trigger.new, Trigger.oldMap);
    }
}