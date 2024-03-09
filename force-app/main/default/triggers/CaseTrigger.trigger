trigger CaseTrigger on Case (before insert, before update, after insert, after update) {

    if(trigger.isBefore){
        if(trigger.isInsert || trigger.isUpdate){
            CaseTriggerHandler.checkDuplicateCases(trigger.New);
        }
    }

    if(trigger.isAfter){
        if(trigger.isInsert || trigger.isupdate){
            CaseTriggerHandler.updateAcctoCaseFields(trigger.New, Trigger.oldMap);
        }
    }
}