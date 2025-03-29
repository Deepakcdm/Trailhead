/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 03-29-2025
 * @last modified by  : Deepak
**/
trigger CampEventTrigger on CAMPX__Event__c (before insert,before update) {

    if(trigger.isBefore && trigger.isInsert){
        CampEventTriggerHandler.updateCampEventNetRevenue(Trigger.New,null);
    }
    else if(Trigger.isBefore && Trigger.isUpdate){
        CampEventTriggerHandler.updateCampEventNetRevenue(Trigger.New,Trigger.oldMap);
    }
}