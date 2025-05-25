/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 05-25-2025
 * @last modified by  : Deepak
**/
trigger LeadTrigger on Lead (after insert) {

    if(Trigger.isAfter && Trigger.isInsert){
        LeadTriggerHandler.createTask(Trigger.New);
    }
}