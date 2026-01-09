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
trigger CampGardenTrigger on CAMPX__Garden__c(before insert, after insert, before update, after update) {
	if (Trigger.isBefore && Trigger.isInsert) {
		CampGarden_TriggerHandler.initializeGardenFields(Trigger.new);
		CampGarden_TriggerHandler.setManagerStartDate(Trigger.new, null);
		CampGarden_TriggerHandler.calculateCapacity(Trigger.new, null);
		CampGarden_TriggerHandler.getHealthIndex(Trigger.new, null);
		CampGarden_TriggerHandler.restrictBlankValues(Trigger.new);
		CampGarden_TriggerHandler.restrictNegativeValues(Trigger.new);
		CampGarden_TriggerHandler.restrictRange(Trigger.new);
		CampGarden_TriggerHandler.setGardenStatus(Trigger.new, null);
	}

	if (Trigger.isBefore && Trigger.isUpdate) {
		CampGarden_TriggerHandler.setManagerStartDate(Trigger.new, Trigger.oldMap);
		CampGarden_TriggerHandler.calculateCapacity(Trigger.new, Trigger.oldMap);
		CampGarden_TriggerHandler.getHealthIndex(Trigger.new, Trigger.oldMap);
		CampGarden_TriggerHandler.restrictBlankValues(Trigger.new);
		CampGarden_TriggerHandler.restrictNegativeValues(Trigger.new);
		CampGarden_TriggerHandler.restrictRange(Trigger.new);
		CampGarden_TriggerHandler.setGardenStatus(Trigger.new, Trigger.oldMap);
	}

	if (Trigger.isAfter && Trigger.isInsert) {
		CampGarden_TriggerHandler.createTaskForManager(Trigger.new);
	}

	if (Trigger.isAfter && Trigger.isUpdate) {
		CampGarden_TriggerHandler.reassignManagerTasks(Trigger.new, Trigger.oldMap);
		CampGarden_TriggerHandler.deleteManagerTasks(Trigger.new, Trigger.oldMap);
	}
}