/**
 * @description       : Case Object Trigger
 * @author            : Deepak Kumar
 * @group             :
 * @last modified on  : 05-25-2025
 **/
trigger CaseTrigger on Case(before insert,before update,after insert,after update, before delete) {
  if(trigger.isBefore && trigger.isInsert){
    CaseTriggerHandler.updateCaseofEmailOrigin(Trigger.New);
    CaseTriggerHandler.updateOwnerQueue(Trigger.New);
  }

  if(trigger.isBefore && trigger.isDelete){
     CaseTriggerHandler.restrictCaseDeletion(Trigger.old);
  }
}
