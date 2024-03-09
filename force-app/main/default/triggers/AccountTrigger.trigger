/**
 * @description       :
 * @author            : Deepak Kumar
 * @group             :
 * @last modified on  : 03-09-2024
 **/
trigger AccountTrigger on Account(before insert, before update, before delete) {

  if(trigger.isBefore && Trigger.isInsert){
    AccountTriggerHandler.restrictNonAdminAccCreate(Trigger.new);
  }

  else if(trigger.isBefore && trigger.isDelete){
    AccountTriggerHandler.restrictAccWithTwoContacts(trigger.oldMap);
    AccountTriggerHandler.restrictAccWithContacts(trigger.oldMap);
  }
  
  else if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
    //AccountTriggerHandler.createAccounts(Trigger.new);
    AccountTriggerHandler.copyShippingAddress(Trigger.new, Trigger.oldMap);
    AccountTriggerHandler.restrictDuplicateAccounts(Trigger.new, Trigger.oldMap);
    /*AccountTriggerHandler.restrictAccwithParentAcc();
    AccountTriggerHandler.updateCaseofEmailOrigin(); */
  }

}
