/**
 * @description       : Trigger on Account Object
 * @author            : Deepak Kumar
 * @group             :
 * @last modified on  : 09-07-2025
 **/
trigger AccountTrigger on Account(before insert, before update, before delete, after insert, after update) {
	if (Trigger.isBefore && Trigger.isInsert) {
		//AccountTriggerHandler.restrictNonAdminAccCreate(Trigger.new);
		//AccountTriggerHandler.restrictDuplicateAccounts(Trigger.new);
		//AccountTriggerHandler.updateDescription(Trigger.new);
	}

	if (Trigger.isBefore && Trigger.isDelete) {
		//AccountTriggerHandler.restrictAccWithTwoContacts(Trigger.oldMap);
		//AccountTriggerHandler.restrictAccWithContacts(Trigger.oldMap);
		//AccountTriggerHandler.restrictAccwithParentAcc(Trigger.oldMap);
	}

	if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
		//AccountTriggerHandler.copyShippingAddress(Trigger.new, Trigger.oldMap);
	}

	if (Trigger.isAfter && Trigger.isInsert) {
		//AccountTriggerHandler.updateAcctStatusAsync(Trigger.new);
		//AccountTriggerHandler.createContact(Trigger.new);
	}
}