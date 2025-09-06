/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 08-31-2025
 * @last modified by  : Deepak
**/
trigger ContactTrigger on Contact (before update) {

    if(trigger.isBefore && trigger.isUpdate){
        ContactTriggerHandler.updateBirthDate(Trigger.new, Trigger.oldMap);
    }

}