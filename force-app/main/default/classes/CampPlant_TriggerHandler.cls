/**
 * @description       :
 * @author            : Deepak
 * @Created on        : 03-30-2025
 * @Created by        : Deepak
 * @last modified on  : 01-09-2026
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
	public static void initializePlantFields(List<CAMPX__Plant__c> newPlants) {
		set<Id> gardenIds = new Set<Id>();
		Map<Id, CAMPX__Garden__c> gardenMap = new Map<Id, CAMPX__Garden__c>();
		for (CAMPX__Plant__c plant : newPlants) {
			if (plant.CAMPX__Garden__c != null) {
				gardenIds.add(plant.CAMPX__Garden__c);
			}
		}

		if (!gardenIds.isEmpty()) {
			for (CAMPX__Garden__c garden : [SELECT Id, CAMPX__Sun_Exposure__c FROM CAMPX__Garden__c WHERE Id IN :gardenIds]) {
				gardenMap.put(garden.Id, garden);
			}
		}

		for (CAMPX__Plant__c plant : newPlants) {
			plant.CAMPX__Soil_Type__c = plant.CAMPX__Soil_Type__c == null ? 'All Purpose Potting Soil' : plant.CAMPX__Soil_Type__c;
			plant.CAMPX__Water__c = plant.CAMPX__Water__c != null ? plant.CAMPX__Water__c : 'Once Weekly';
			plant.CAMPX__Sunlight__c = string.isNotBlank(plant.CAMPX__Sunlight__c)
				? plant.CAMPX__Sunlight__c
				: gardenMap.get(plant.CAMPX__Garden__c)?.CAMPX__Sun_Exposure__c != null ? gardenMap.get(plant.CAMPX__Garden__c)?.CAMPX__Sun_Exposure__c : 'Partial Sun';
		}
	}

	/**
	 * @description
	 * @author Deepak | 04-04-2025
	 * @param List<CAMPX__Plant__c> newPlants
	 **/
	public static void restrictPlantsOnClosedGardens(List<CAMPX__Plant__c> newPlants, Map<Id, CAMPX__Plant__c> oldPlants) {
		Map<Id, List<CAMPX__Plant__c>> plantGardenMap = new Map<Id, List<CAMPX__Plant__c>>();
		for (CAMPX__Plant__c plant : newPlants) {
			if (plant.CAMPX__Garden__c != null && (oldPlants == null || (oldPlants != null && plant.CAMPX__Garden__c != oldPlants.get(plant.id)?.CAMPX__Garden__c))) {
				if (!plantGardenMap.containskey(plant.CAMPX__Garden__c)) {
					plantGardenMap.put(plant.CAMPX__Garden__c, new List<CAMPX__Plant__c>{ plant });
				} else {
					plantGardenMap.get(plant.CAMPX__Garden__c).add(plant);
				}
			}
		}

		if (!plantGardenMap.isEmpty()) {
			set<Id> closedGardens = new Set<Id>();
			for (CAMPX__Garden__c garden : [
				SELECT Id, CAMPX__Status__c
				FROM CAMPX__Garden__c
				WHERE CAMPX__Status__c = 'Permanent Closure' AND ID IN :plantGardenMap.keyset()
			]) {
				closedGardens.add(garden.id);
			}

			for (Id gardenId : plantGardenMap.keyset()) {
				if (closedGardens.contains(gardenId)) {
					for (CAMPX__Plant__c plant : plantGardenMap.get(gardenId)) {
						plant.addError('The garden selected for this plant is permanently closed. Please select a different garden.');
					}
				}
			}
		}
	}

	/**
	 * @description
	 * @author Deepak | 04-07-2025
	 **/
	public static void aggregateTotalPlantCount(List<CAMPX__Plant__c> newPlants, Map<Id, CAMPX__Plant__c> oldPlants) {
		set<Id> gardenIds = new Set<Id>();
		if (newPlants != null) {
			for (CAMPX__Plant__c plant : newPlants) {
				if ((oldPlants == null || (oldPlants != null && plant.CAMPX__Garden__c != oldPlants.get(plant.id)?.CAMPX__Garden__c))) {
					gardenIds.add(plant.CAMPX__Garden__c);
					gardenIds.add(oldPlants?.get(plant.id)?.CAMPX__Garden__c);
				}
			}
		} else if (newPlants == null) {
			for (CAMPX__Plant__c plant : oldPlants.Values()) {
				gardenIds.add(oldPlants?.get(plant.id)?.CAMPX__Garden__c);
			}
		}

		gardenIds.remove(null);

		if (!gardenIds.isEmpty()) {
			Map<Id, Integer> plantCountMap = new Map<Id, Integer>();
			List<CAMPX__Garden__c> updatedGardens = new List<CAMPX__Garden__c>();
			List<AggregateResult> groupedPlants = [
				SELECT CAMPX__Garden__c, Count(Id) plantsCount
				FROM CAMPX__Plant__c
				WHERE CAMPX__Garden__c IN :gardenIds
				GROUP BY CAMPX__Garden__c
			];

			for (AggregateResult ar : groupedPlants) {
				Id gardenId = (Id) ar.get('CAMPX__Garden__c');
				Integer plantCount = (Integer) ar.get('plantsCount');
				plantCountMap.put(gardenId, plantCount);
			}

			for (Id gardenId : gardenIds) {
				if (plantCountMap.containsKey(gardenId)) {
					updatedGardens.add(new CAMPX__Garden__c(Id = gardenId, CAMPX__Total_Plant_Count__c = plantCountMap.get(gardenId)));
				} else {
					updatedGardens.add(new CAMPX__Garden__c(Id = gardenId, CAMPX__Total_Plant_Count__c = 0));
				}
			}

			Database.update(updatedGardens);
		}
	}

	/**
	 * @description
	 * @author Deepak | 04-07-2025
	 **/
	public static void aggregateUnhealthyPlantCount(List<CAMPX__Plant__c> newPlants, Map<Id, CAMPX__Plant__c> oldPlants) {
		set<Id> gardenIds = new Set<Id>();
		if (newPlants != null) {
			for (CAMPX__Plant__c plant : newPlants) {
				if ((oldPlants == null || (oldPlants != null && plant.CAMPX__Status__c != oldPlants.get(plant.id)?.CAMPX__Status__c))) {
					gardenIds.add(plant.CAMPX__Garden__c);
					gardenIds.add(oldPlants?.get(plant.id)?.CAMPX__Garden__c);
				}
			}
		} else if (newPlants == null) {
			for (CAMPX__Plant__c plant : oldPlants.Values()) {
				gardenIds.add(oldPlants?.get(plant.id)?.CAMPX__Garden__c);
			}
		}
		gardenIds.remove(null);

		if (!gardenIds.isEmpty()) {
			List<CAMPX__Garden__c> updatedGardens = new List<CAMPX__Garden__c>();
			Map<Id, Integer> plantCountMap = new Map<Id, Integer>();
			List<AggregateResult> groupedPlants = [
				SELECT CAMPX__Garden__c, Count(Id) unHealthyPlantCount
				FROM CAMPX__Plant__c
				WHERE CAMPX__Status__c IN ('Deceased', 'Sick', 'Wilting') AND CAMPX__Garden__c IN :gardenIds
				GROUP BY CAMPX__Garden__c
			];

			for (AggregateResult ar : groupedPlants) {
				Id gardenId = (Id) ar.get('CAMPX__Garden__c');
				Integer unHealthyPlantCount = (Integer) ar.get('unHealthyPlantCount');
				plantCountMap.put(gardenId, unHealthyPlantCount);
			}

			for (Id gardenId : gardenIds) {
				if (plantCountMap.containsKey(gardenId)) {
					updatedGardens.add(new CAMPX__Garden__c(Id = gardenId, CAMPX__Total_Unhealthy_Plant_Count__c = plantCountMap.get(gardenId)));
				} else {
					updatedGardens.add(new CAMPX__Garden__c(Id = gardenId, CAMPX__Total_Unhealthy_Plant_Count__c = 0));
				}
			}
			Database.update(updatedGardens);
		}
	}
}