/**
 * @description       : 
 * @author            : Deepak
 * @Created on        : 03-30-2025
 * @Created by        : Deepak
 * @last modified on  : 03-31-2025
 * @last modified by  : Deepak 
 * Modifications Log
 * Ver   Date         Author   Modification
 * 1.0   03-30-2025   Deepak   Initial Version
**/
public with sharing class CampGarden_TriggerHandler {

    /**
    * @description 
    * @author Deepak | 03-30-2025 
    * @param List<CAMPX__Garden__c> newGardens 
    **/
    public static void initializeGardenFields(List<CAMPX__Garden__c> newGardens){
        for(CAMPX__Garden__c garden : newGardens){
            garden.CAMPX__Status__c=garden.CAMPX__Status__c==null ? 'Awaiting Resources' : garden.CAMPX__Status__c;
            garden.CAMPX__Max_Plant_Count__c=garden.CAMPX__Max_Plant_Count__c==null ? 100 : garden.CAMPX__Max_Plant_Count__c;
            garden.CAMPX__Minimum_Plant_Count__c=garden.CAMPX__Minimum_Plant_Count__c==null ? 1 : garden.CAMPX__Minimum_Plant_Count__c;
            garden.CAMPX__Total_Plant_Count__c=garden.CAMPX__Total_Plant_Count__c==null ? 0 : garden.CAMPX__Total_Plant_Count__c;
            garden.CAMPX__Total_Unhealthy_Plant_Count__c=garden.CAMPX__Total_Unhealthy_Plant_Count__c==null ? 0 :  garden.CAMPX__Total_Unhealthy_Plant_Count__c;
        }
    }

    /**
    * @description 
    * @author Deepak | 03-30-2025 
    * @param List<CAMPX__Garden__c> newGardens 
    **/
    public static void createTaskForManager(List<CAMPX__Garden__c> newGardens){
        List<Task> managerTasks = new List<Task>();
        for(CAMPX__Garden__c garden : newGardens){
            if(garden.CAMPX__Manager__c!=null){
                managerTasks.add(new Task(Subject='Acquire Plants',whatId=garden.Id,OwnerId=garden.CAMPX__Manager__c));
            }
        }

        if(!managerTasks.isEmpty()){
            Database.insert(managerTasks);
        }
    }

    /**
    * @description 
    * @author Deepak | 03-31-2025 
    * @param List<CAMPX__Garden__c> newGardens 
    * @param Map<Id CAMPX__Garden__c> oldGardens 
    **/
    public static void deleteManagerTasks(List<CAMPX__Garden__c> newGardens, Map<Id,CAMPX__Garden__c> oldGardens){
        set<Id> gardenIds = new set<Id>();
        set<Id> oldMgrIds = new set<Id>();
        for(CAMPX__Garden__c garden : newGardens){
            if(garden.CAMPX__Manager__c!= oldGardens.get(garden.Id)?.CAMPX__Manager__c && garden.CAMPX__Manager__c==null){
                gardenIds.add(garden.Id);
                oldMgrIds.add(oldGardens.get(garden.Id)?.CAMPX__Manager__c);
            }
        }

        if(!oldMgrIds.isEmpty()){
            List<Task> deleteTasks = new List<Task>();
            for(Task tsk : [Select Id from Task where OwnerId IN :oldMgrIds AND Subject='Acquire Plants' AND WhatId IN :gardenIds AND Status!= 'Completed']){
                deleteTasks.add(tsk);
            }

            Database.delete(deleteTasks);
        }
    }

    /**
    * @description 
    * @author Deepak | 03-31-2025 
    * @param List<CAMPX__Garden__c> newGardens 
    * @param Map<Id CAMPX__Garden__c> oldGardens 
    **/
    public static void setManagerStartDate(List<CAMPX__Garden__c> newGardens, Map<Id,CAMPX__Garden__c> oldGardens){
        for(CAMPX__Garden__c garden : newGardens){
            if(oldGardens==null || (oldGardens!=null && garden.CAMPX__Manager__c!= oldGardens.get(garden.Id)?.CAMPX__Manager__c)){
                garden.CAMPX__Manager_Start_Date__c=garden.CAMPX__Manager__c!=null ? Date.Today() : null;
            }
        }
    }

    /**
    * @description 
    * @author Deepak | 03-31-2025 
    **/
    public static void reassignManagerTasks(List<CAMPX__Garden__c> newGardens, Map<Id,CAMPX__Garden__c> oldGardens){
        Map<String,String> gardenOwnerChangeMap = new Map<String,String>();
        set<Id> gardenIds = new set<Id>();
        set<Id> oldMgrIds = new Set<Id>();
        List<Task> reassignTasks = new List<Task>();

        for(CAMPX__Garden__c garden : newGardens){
            if(garden.CAMPX__Manager__c!= oldGardens.get(garden.Id)?.CAMPX__Manager__c && garden.CAMPX__Manager__c!=null){
                gardenOwnerChangeMap.put(garden.Id+'-'+oldGardens.get(garden.Id)?.CAMPX__Manager__c, garden.CAMPX__Manager__c);
                gardenIds.add(garden.Id);
                oldMgrIds.add(oldGardens.get(garden.Id)?.CAMPX__Manager__c);
            }
        }

        if(!gardenIds.isEmpty()){
            for(Task tsk : [Select Id,WhatId,OwnerId from Task where WhatId IN :gardenIds AND OwnerId IN :oldMgrIds AND Status!='Completed' AND Subject='Acquire Plants']){
                if(gardenOwnerChangeMap.containsKey(tsk.WhatId+'-'+tsk.OwnerId)){
                    reassignTasks.add(new Task(Id=tsk.Id, OwnerId = gardenOwnerChangeMap.get(tsk.WhatId+'-'+tsk.OwnerId)));
                }
            }
            Database.update(reassignTasks);
        }
    }

    /**
    * @description 
    * @author Deepak | 03-31-2025 
    **/
    public static void calculateCapacity(List<CAMPX__Garden__c> newGardens , Map<Id,CAMPX__Garden__c> oldGardens){
        for(CAMPX__Garden__c garden : newGardens){
            Boolean totalPlantCountChanged = oldGardens!=null && garden.CAMPX__Total_Plant_Count__c!= oldGardens.get(garden.Id)?.CAMPX__Total_Plant_Count__c;
            Boolean maxPlantCountChanged = oldGardens!=null && garden.CAMPX__Max_Plant_Count__c!= oldGardens.get(garden.Id)?.CAMPX__Max_Plant_Count__c;
            if((oldGardens==null || totalPlantCountChanged || maxPlantCountChanged)){
                garden.CAMPX__Capacity__c = garden.CAMPX__Total_Plant_Count__c > 0 && garden.CAMPX__Max_Plant_Count__c > 0 ? 
                (garden.CAMPX__Total_Plant_Count__c/garden.CAMPX__Max_Plant_Count__c)*100 : 0;
            }
        }
    }

    /**
    * @description 
    * @author Deepak | 03-31-2025 
    **/
    public static void getHealthIndex(List<CAMPX__Garden__c> newGardens , Map<Id,CAMPX__Garden__c> oldGardens){
        for(CAMPX__Garden__c garden : newGardens){
            Boolean totalPlantCountChanged = oldGardens!=null && garden.CAMPX__Total_Plant_Count__c!= oldGardens.get(garden.Id)?.CAMPX__Total_Plant_Count__c;
            Boolean unhealthPlantCountChanged = oldGardens!=null && garden.CAMPX__Total_Unhealthy_Plant_Count__c!= oldGardens.get(garden.Id)?.CAMPX__Total_Unhealthy_Plant_Count__c;
            if(oldGardens==null || totalPlantCountChanged || unhealthPlantCountChanged){
                garden.CAMPX__Health_Index__c = garden.CAMPX__Total_Plant_Count__c > 0 ? ((garden.CAMPX__Total_Plant_Count__c-garden.CAMPX__Total_Unhealthy_Plant_Count__c)/garden.CAMPX__Total_Plant_Count__c)*100 : 0;
            }
        }
    }

    /**
    * @description 
    * @author Deepak | 03-31-2025 
    **/
    public static void restrictBlankValues(List<CAMPX__Garden__c> newGardens){
        for(CAMPX__Garden__c garden : newGardens){
            if(garden.CAMPX__Total_Plant_Count__c > 0 && (garden.CAMPX__Max_Plant_Count__c==null || garden.CAMPX__Minimum_Plant_Count__c==null)){
                garden.addError('Maximum and Minimum Plant Count fields cannot be blank when there are plants in the Garden.');
            }
        }
    }

    /**
    * @description 
    * @author Deepak | 03-31-2025 
    **/
    public static void restrictNegativeValues(List<CAMPX__Garden__c> newGardens){
        for(CAMPX__Garden__c garden : newGardens){
            if(garden.CAMPX__Max_Plant_Count__c < 0 || garden.CAMPX__Minimum_Plant_Count__c < 0 || garden.CAMPX__Total_Plant_Count__c < 0 || garden.CAMPX__Total_Unhealthy_Plant_Count__c < 0){
                garden.addError('Plant Count fields must be greater than or equal to zero.');
            }
        }
    }

    /**
    * @description 
    * @author Deepak | 03-31-2025 
    **/
    public static void restrictRange(List<CAMPX__Garden__c> newGardens){
        for(CAMPX__Garden__c garden : newGardens){
            if(garden.CAMPX__Max_Plant_Count__c > 0 && garden.CAMPX__Minimum_Plant_Count__c > 0 && garden.CAMPX__Max_Plant_Count__c < garden.CAMPX__Minimum_Plant_Count__c){
                garden.addError('The Maximum Plant Count must be greater than or equal to the Minimum Plant Count');
            }
        }
    }
}