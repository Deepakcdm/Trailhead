public with sharing class AnimalTriggerHandler {

    public static void updateRegion1(List<Animal__c> newAnimals, Map<Id,Animal__c> oldAnimalMap){
        for(Animal__c animal : newAnimals){
            animal.Region__c = 'South India';
        }
    }

     public static void updateRegion2(List<Animal__c> newAnimals, Map<Id,Animal__c> oldAnimalMap){
        for(Animal__c animal : newAnimals){

        }
    }
}