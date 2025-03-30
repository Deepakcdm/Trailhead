/**
 * @description       : 
 * @author            : Deepak
 * @Created on        : 03-30-2025
 * @Created by        : Deepak
 * @last modified on  : 03-30-2025
 * @last modified by  : Deepak 
 * Modifications Log
 * Ver   Date         Author   Modification
 * 1.0   03-30-2025   Deepak   Initial Version
**/
trigger CampGardenTrigger on CAMPX__Garden__c (before insert,after insert, after update) {

    if(trigger.isBefore && trigger.isInsert){
        CampGarden_TriggerHandler.initializeGardenFields(Trigger.new);
    }

    if(trigger.isAfter && trigger.isInsert){
        CampGarden_TriggerHandler.createTaskForManager(Trigger.new,null);
    }

    if(trigger.isAfter && trigger.isUpdate){
        CampGarden_TriggerHandler.createTaskForManager(Trigger.new,Trigger.oldMap);
    }

}