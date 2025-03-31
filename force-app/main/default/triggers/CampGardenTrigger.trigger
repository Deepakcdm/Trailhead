/**
 * @description       : 
 * @author            : Deepak
 * @Created on        : 03-30-2025
 * @Created by        : Deepak
 * @last modified on  : 03-31-2025
 * @last modified by  : Deepak 
 * Modifications Log
 * Ver   Date         Author   Modification
 * 1.0   03-30-2025   Deepak   Initial Version
**/
trigger CampGardenTrigger on CAMPX__Garden__c (before insert,after insert, before update,after update) {

    if(trigger.isBefore && trigger.isInsert){
        CampGarden_TriggerHandler.initializeGardenFields(Trigger.new);
        CampGarden_TriggerHandler.setManagerStartDate(Trigger.new,null);
        CampGarden_TriggerHandler.calculateCapacity(Trigger.new,null);
        CampGarden_TriggerHandler.getHealthIndex(Trigger.new,null);
    }

    if(trigger.isBefore && trigger.isUpdate){
        CampGarden_TriggerHandler.setManagerStartDate(Trigger.new,Trigger.oldMap);
        CampGarden_TriggerHandler.calculateCapacity(Trigger.new,Trigger.oldMap);
        CampGarden_TriggerHandler.getHealthIndex(Trigger.new,Trigger.oldMap);
    }

    if(trigger.isAfter && trigger.isInsert){
        CampGarden_TriggerHandler.createTaskForManager(Trigger.new);
    }

    if(trigger.isAfter && trigger.isUpdate){
        CampGarden_TriggerHandler.reassignManagerTasks(Trigger.new,Trigger.oldMap);
        CampGarden_TriggerHandler.deleteManagerTasks(Trigger.new, Trigger.oldMap);
    }
}