/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 11-20-2024
 * @last modified by  : Deepak
**/
public with sharing class AnimalTriggerHandler {

    /**
    * @description 
    * @author Deepak | 11-20-2024 
    * @param List<Animal__c> newAnimals 
    * @param Map<Id Animal__c> oldAnimalMap 
    **/
    public static void updateRegion1(List<Animal__c> newAnimals, Map<Id,Animal__c> oldAnimalMap){
        for(Animal__c animal : newAnimals){
            animal.Region__c = 'South India';
        }
    }

     /**
     * @description 
     * @author Deepak | 11-20-2024 
     * @param List<Animal__c> newAnimals 
     * @param Map<Id Animal__c> oldAnimalMap 
     **/
     public static void updateRegion2(List<Animal__c> newAnimals, Map<Id,Animal__c> oldAnimalMap){
        for(Animal__c animal : newAnimals){

        }
    }
}