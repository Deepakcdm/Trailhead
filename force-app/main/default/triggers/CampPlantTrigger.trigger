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
trigger CampPlantTrigger on CAMPX__Plant__c (before insert, before update, after insert , after update, after delete) {

    if(trigger.isInsert && trigger.isBefore){
        CampPlant_TriggerHandler.initializePlantFields(Trigger.new);
        CampPlant_TriggerHandler.restrictPlantsOnClosedGardens(Trigger.new, null);
    }

    if(trigger.isBefore && trigger.isUpdate){
        CampPlant_TriggerHandler.restrictPlantsOnClosedGardens(Trigger.new, Trigger.oldMap);
    }

    if(trigger.isAfter && trigger.isInsert){
        CampPlant_TriggerHandler.aggregateTotalPlantCount(Trigger.new, null);
        CampPlant_TriggerHandler.aggregateUnhealthyPlantCount(Trigger.new, null);
    }

    if(trigger.isAfter && trigger.isUpdate){
        CampPlant_TriggerHandler.aggregateTotalPlantCount(Trigger.new, Trigger.oldMap);
        CampPlant_TriggerHandler.aggregateUnhealthyPlantCount(Trigger.new, Trigger.oldMap);
    }

    if(trigger.isAfter && trigger.isDelete){
        CampPlant_TriggerHandler.aggregateTotalPlantCount(Trigger.new, Trigger.oldMap);
        CampPlant_TriggerHandler.aggregateUnhealthyPlantCount(Trigger.new, Trigger.oldMap);
    }
}