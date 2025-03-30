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
public with sharing class CampPlant_TriggerHandler {

    /**
    * @description 
    * @author Deepak | 03-30-2025 
    **/
    public static void initializePlantFields(List<CAMPX__Plant__c> newPlants){
        set<Id> gardenIds = new set<Id>();
        Map<Id,CAMPX__Garden__c> gardenMap = new Map<Id,CAMPX__Garden__c>();
        for(CAMPX__Plant__c plant : newPlants){
            if(plant.CAMPX__Garden__c!=null){
                gardenIds.add(plant.CAMPX__Garden__c);
            }
        }

        if(!gardenIds.isEmpty()){
            for(CAMPX__Garden__c garden : [Select Id,CAMPX__Sun_Exposure__c from CAMPX__Garden__c Where Id IN: gardenIds]){
                gardenMap.put(garden.Id, garden);
            }
        }

        for(CAMPX__Plant__c plant : newPlants){
            plant.CAMPX__Soil_Type__c=plant.CAMPX__Soil_Type__c==null ? 'All Purpose Potting Soil' : plant.CAMPX__Soil_Type__c;
            plant.CAMPX__Water__c=plant.CAMPX__Water__c!=null ? plant.CAMPX__Water__c : 'Once Weekly';
            plant.CAMPX__Sunlight__c=string.isNotBlank( plant.CAMPX__Sunlight__c) ? plant.CAMPX__Sunlight__c : 
            gardenMap.get(plant.CAMPX__Garden__c)?.CAMPX__Sun_Exposure__c!=null ? gardenMap.get(plant.CAMPX__Garden__c)?.CAMPX__Sun_Exposure__c : 'Partial Sun';
        }
    }
}