/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 09-07-2025
 * @last modified by  : Deepak
**/
trigger ContactTrigger on Contact (before insert, after insert, after update, before update, after delete) {

    if(trigger.isBefore && trigger.isInsert){
        ContactTriggerHandler.restrictDuplicateContacts(Trigger.new,null);
    }

    if(trigger.isBefore && trigger.isUpdate){
        ContactTriggerHandler.updateBirthDate(Trigger.new, Trigger.oldMap);
        ContactTriggerHandler.restrictDuplicateContacts(Trigger.new,Trigger.oldMap);
    }

    if(trigger.isAfter && trigger.isInsert){
        ContactTriggerHandler.updateContactsCount(Trigger.new,null);
    }

    if(trigger.isAfter && trigger.isUpdate){
        ContactTriggerHandler.updateContactsCount(Trigger.new,Trigger.oldMap);
    }

    if(trigger.isAfter && trigger.isDelete){
        ContactTriggerHandler.UpdateContactsCount(null, Trigger.oldMap);
    }

}