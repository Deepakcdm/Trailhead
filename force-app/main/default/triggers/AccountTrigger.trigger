/**
 * @description       : Trigger on Account Object
 * @author            : Deepak Kumar
 * @group             :
 * @last modified on  : 04-05-2024
 **/
trigger AccountTrigger on Account(before insert, before update, before delete, after insert, after update) {

  if(trigger.isBefore && Trigger.isInsert){
    AccountTriggerHandler.restrictNonAdminAccCreate(Trigger.new);
    AccountTriggerHandler.restrictDuplicateAccounts(Trigger.new);
  }

  else if(trigger.isBefore && trigger.isDelete){
    AccountTriggerHandler.restrictAccWithTwoContacts(Trigger.oldMap);
    AccountTriggerHandler.restrictAccWithContacts(Trigger.oldMap);
    AccountTriggerHandler.restrictAccwithParentAcc(Trigger.oldMap);
  }
  
  else if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
    AccountTriggerHandler.copyShippingAddress(Trigger.new, Trigger.oldMap);
  }

}