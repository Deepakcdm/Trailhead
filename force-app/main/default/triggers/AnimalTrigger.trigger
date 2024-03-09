trigger AnimalTrigger on Animal__c (before insert,before update) {

    if(trigger.isBefore && Trigger.isUpdate){
       AnimalTriggerHandler.updateRegion1(Trigger.new, Trigger.oldMap);
       AnimalTriggerHandler.updateRegion2(Trigger.new,Trigger.oldMap);
    }
}