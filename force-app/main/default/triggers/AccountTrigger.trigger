/**
 * @description       :
 * @author            : Deepak Kumar
 * @group             :
 * @last modified on  : 03-09-2024
 **/
trigger AccountTrigger on Account(before insert, before update) {

  if(trigger.isBefore && Trigger.isInsert){
    AccountTriggerHandler.restrictNonAdminAccCreate();
  }
  
  else if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
    //AccountTriggerHandler.createAccounts(Trigger.new);
    AccountTriggerHandler.copyShippingAddress(Trigger.new, Trigger.oldMap);
    AccountTriggerHandler.restrictDuplicateAccounts(Trigger.new, Trigger.oldMap);
   /* AccountTriggerHandler.restrictAccWithTwoContacts();
    AccountTriggerHandler.restrictAccWithContacts();
    AccountTriggerHandler.restrictClosedOppUpdate();
    AccountTriggerHandler.restrictAccwithParentAcc();
    AccountTriggerHandler.updateCaseofEmailOrigin(); */
  }

}
