/**
 * @description       :
 * @author            : Deepak
 * @group             :
 * @last modified on  : 01-03-2026
 * @last modified by  : Deepak
 **/
trigger ContactTrigger on Contact(before insert, after insert, after update, before update, after delete) {
	if (Trigger.isBefore && Trigger.isInsert) {
		ContactTriggerHandler.restrictDuplicateContacts(Trigger.new, null);
	}

	if (Trigger.isBefore && Trigger.isUpdate) {
		ContactTriggerHandler.updateBirthDate(Trigger.new, Trigger.oldMap);
		ContactTriggerHandler.restrictDuplicateContacts(Trigger.new, Trigger.oldMap);
	}

	if (Trigger.isAfter && Trigger.isInsert) {
		ContactTriggerHandler.updateContactsCount(Trigger.new, null);
	}

	if (Trigger.isAfter && Trigger.isUpdate) {
		ContactTriggerHandler.updateContactsCount(Trigger.new, Trigger.oldMap);
	}

	if (Trigger.isAfter && Trigger.isDelete) {
		ContactTriggerHandler.UpdateContactsCount(null, Trigger.oldMap);
	}

}