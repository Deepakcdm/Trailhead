/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 12-22-2024
 * @last modified by  : Deepak
**/
@istest
public with sharing class AnimalTriggerHandlerTest {
    
@isTest
    static void testAnimalTriggerHandler() {
        List<Animal__c> animals = [SELECT Id, Name, Region__c FROM Animal__c];
        
        Test.startTest();
        AnimalTriggerHandler.updateRegion1(animals, new Map<Id,Animal__c>());
        Test.stopTest();
        
        List<Animal__c> updatedAnimals = [SELECT Id, Name, Region__c FROM Animal__c];
        for (Animal__c animal : updatedAnimals) {
            System.assertEquals('South India', animal.Region__c);
        }
    }
@isTest
    static void testAnimalTriggerHandler2() {
        List<Animal__c> animals = [SELECT Id, Name, Region__c FROM Animal__c];
        Map<Id,Animal__c> oldAnimalMap = new Map<Id,Animal__c>();
        for(Animal__c animal : animals){
            oldAnimalMap.put(animal.Id, animal);
        }
        Test.startTest();
        AnimalTriggerHandler.updateRegion2(animals, oldAnimalMap);
        Test.stopTest();
        
        List<Animal__c> updatedAnimals = [SELECT Id, Name, Region__c FROM Animal__c];
        for (Animal__c animal : updatedAnimals) {
            System.assertEquals(null, animal.Region__c);
        }
    }}