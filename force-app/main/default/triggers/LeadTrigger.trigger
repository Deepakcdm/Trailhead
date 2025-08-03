/**
 * @description       : Lead 
 * @author            : Deepak
 * @group             :
 * @last modified on  : 06-08-2025
 * @last modified by  : Deepak
**/
trigger LeadTrigger on Lead (after insert) {

    if(Trigger.isAfter && Trigger.isInsert){
        LeadTriggerHandler.createTask(Trigger.New);
    }
}