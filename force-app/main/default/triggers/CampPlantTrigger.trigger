/**
 * @description       :
 * @author            : Deepak
 * @Created on        : 03-30-2025
 * @Created by        : Deepak
 * @last modified on  : 01-09-2026
 * @last modified by  : Deepak
 * Modifications Log
 * Ver   Date         Author   Modification
 * 1.0   03-30-2025   Deepak   Initial Version
 **/
trigger CampPlantTrigger on CAMPX__Plant__c(before insert, before update, after insert, after update, after delete) {
	if (Trigger.isInsert && Trigger.isBefore) {
		CampPlant_TriggerHandler.initializePlantFields(Trigger.new);
		CampPlant_TriggerHandler.restrictPlantsOnClosedGardens(Trigger.new, null);
	}

	if (Trigger.isBefore && Trigger.isUpdate) {
		CampPlant_TriggerHandler.restrictPlantsOnClosedGardens(Trigger.new, Trigger.oldMap);
	}

	if (Trigger.isAfter && Trigger.isInsert) {
		CampPlant_TriggerHandler.aggregateTotalPlantCount(Trigger.new, null);
		CampPlant_TriggerHandler.aggregateUnhealthyPlantCount(Trigger.new, null);
	}

	if (Trigger.isAfter && Trigger.isUpdate) {
		CampPlant_TriggerHandler.aggregateTotalPlantCount(Trigger.new, Trigger.oldMap);
		CampPlant_TriggerHandler.aggregateUnhealthyPlantCount(Trigger.new, Trigger.oldMap);
	}

	if (Trigger.isAfter && Trigger.isDelete) {
		CampPlant_TriggerHandler.aggregateTotalPlantCount(Trigger.new, Trigger.oldMap);
		CampPlant_TriggerHandler.aggregateUnhealthyPlantCount(Trigger.new, Trigger.oldMap);
	}
}