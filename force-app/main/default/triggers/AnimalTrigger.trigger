/**
 * @name: AnimalTrigger
 * @description: Trigger that executes before inserting or updating Animal records.
 * It calls the AnimalTriggerHandler to update the Region and the HasFlight field based on the given criteria.
 */
trigger AnimalTrigger on Animal__c (before insert,before update) {

    if(trigger.isBefore && Trigger.isUpdate){
       AnimalTriggerHandler.updateRegion1(Trigger.new, Trigger.oldMap);
       AnimalTriggerHandler.updateRegion2(Trigger.new,Trigger.oldMap);
    }
}