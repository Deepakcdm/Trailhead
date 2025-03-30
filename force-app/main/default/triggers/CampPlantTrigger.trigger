/**
 * @description       : 
 * @author            : Deepak
 * @Created on        : 03-30-2025
 * @Created by        : Deepak
 * @last modified on  : 03-30-2025
 * @last modified by  : Deepak 
 * Modifications Log
 * Ver   Date         Author   Modification
 * 1.0   03-30-2025   Deepak   Initial Version
**/
trigger CampPlantTrigger on CAMPX__Plant__c (before insert) {

    if(trigger.isInsert && trigger.isBefore){
        CampPlant_TriggerHandler.initializePlantFields(Trigger.new);
    }

}