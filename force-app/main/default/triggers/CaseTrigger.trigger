/**
 * @description       : Case Object Trigger
 * @author            : Deepak Kumar
 * @group             :
 * @last modified on  : 03-11-2024
 **/
trigger CaseTrigger on Case(before insert,before update,after insert,after update, before delete) {
  if(trigger.isBefore && trigger.isInsert){
    CaseTriggerHandler.updateCaseofEmailOrigin(Trigger.New);
  }
}
