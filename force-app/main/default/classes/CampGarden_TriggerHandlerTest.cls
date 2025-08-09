@isTest
public class CampGarden_TriggerHandlerTest {

    @isTest
    static void testInitializeGardenFields() {
        // Create test data
        List<CAMPX__Garden__c> gardens = new List<CAMPX__Garden__c>{
            new CAMPX__Garden__c(Name = 'Garden 1'),
            new CAMPX__Garden__c(Name = 'Garden 2', CAMPX__Status__c = 'Operational')
        };

        Test.startTest();
        CampGarden_TriggerHandler.initializeGardenFields(gardens);
        Test.stopTest();

        // Assert default values are set
        System.assertEquals('Awaiting Resources', gardens[0].CAMPX__Status__c, 'Default status should be set.');
        System.assertEquals(100, gardens[0].CAMPX__Max_Plant_Count__c, 'Default max plant count should be set.');
        System.assertEquals(1, gardens[0].CAMPX__Minimum_Plant_Count__c, 'Default minimum plant count should be set.');
    }

    @isTest
    static void testCreateTaskForManager() {
        // Create test data
        CAMPX__Garden__c garden = new CAMPX__Garden__c(Name = 'Garden 1', CAMPX__Manager__c = UserInfo.getUserId());
        insert garden;

        Test.startTest();
        CampGarden_TriggerHandler.createTaskForManager(new List<CAMPX__Garden__c>{garden});
        Test.stopTest();

        // Assert task is created
        Task managerTask = [SELECT Id, Subject FROM Task WHERE WhatId = :garden.Id LIMIT 1];
        System.assertEquals('Acquire Plants', managerTask.Subject, 'Task subject should match.');
    }

    @isTest
    static void testDeleteManagerTasks() {
        // Create test data
        CAMPX__Garden__c garden = new CAMPX__Garden__c(Name = 'Garden 1', CAMPX__Manager__c = UserInfo.getUserId());
        insert garden;

        Task task = new Task(Subject = 'Acquire Plants', WhatId = garden.Id, OwnerId = UserInfo.getUserId());
        insert task;

        garden.CAMPX__Manager__c = null;
        Map<Id, CAMPX__Garden__c> oldGardens = new Map<Id, CAMPX__Garden__c>{garden.Id => garden};

        Test.startTest();
        CampGarden_TriggerHandler.deleteManagerTasks(new List<CAMPX__Garden__c>{garden}, oldGardens);
        Test.stopTest();

        // Assert task is deleted
        List<Task> tasks = [SELECT Id FROM Task WHERE WhatId = :garden.Id];
        System.assertEquals(0, tasks.size(), 'Task should be deleted.');
    }

    @isTest
    static void testSetManagerStartDate() {
        // Create test data
        CAMPX__Garden__c garden = new CAMPX__Garden__c(Name = 'Garden 1', CAMPX__Manager__c = UserInfo.getUserId());
        Map<Id, CAMPX__Garden__c> oldGardens = new Map<Id, CAMPX__Garden__c>();

        Test.startTest();
        CampGarden_TriggerHandler.setManagerStartDate(new List<CAMPX__Garden__c>{garden}, oldGardens);
        Test.stopTest();

        // Assert manager start date is set
        System.assertEquals(Date.today(), garden.CAMPX__Manager_Start_Date__c, 'Manager start date should be set.');
    }

    @isTest
    static void testCalculateCapacity() {
        // Create test data
        CAMPX__Garden__c garden = new CAMPX__Garden__c(Name = 'Garden 1', CAMPX__Total_Plant_Count__c = 50, CAMPX__Max_Plant_Count__c = 100);
        Map<Id, CAMPX__Garden__c> oldGardens = new Map<Id, CAMPX__Garden__c>();

        Test.startTest();
        CampGarden_TriggerHandler.calculateCapacity(new List<CAMPX__Garden__c>{garden}, oldGardens);
        Test.stopTest();

        // Assert capacity is calculated
        System.assertEquals(50, garden.CAMPX__Capacity__c, 'Capacity should be calculated correctly.');
    }

    @isTest
    static void testGetHealthIndex() {
        // Create test data
        CAMPX__Garden__c garden = new CAMPX__Garden__c(Name = 'Garden 1', CAMPX__Total_Plant_Count__c = 50, CAMPX__Total_Unhealthy_Plant_Count__c = 10);
        Map<Id, CAMPX__Garden__c> oldGardens = new Map<Id, CAMPX__Garden__c>();

        Test.startTest();
        CampGarden_TriggerHandler.getHealthIndex(new List<CAMPX__Garden__c>{garden}, oldGardens);
        Test.stopTest();

        // Assert health index is calculated
        System.assertEquals(80, garden.CAMPX__Health_Index__c, 'Health index should be calculated correctly.');
    }

    @isTest
    static void testRestrictBlankValues() {
        // Create test data
        CAMPX__Garden__c garden = new CAMPX__Garden__c(Name = 'Garden 1', CAMPX__Total_Plant_Count__c = 10);

        Test.startTest();
        try {
            CampGarden_TriggerHandler.restrictBlankValues(new List<CAMPX__Garden__c>{garden});
            System.assert(false, 'Expected exception for blank values.');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('Maximum and Minimum Plant Count fields cannot be blank'), 'Error message should match.');
        }
        Test.stopTest();
    }

    @isTest
    static void testRestrictNegativeValues() {
        // Create test data
        CAMPX__Garden__c garden = new CAMPX__Garden__c(Name = 'Garden 1', CAMPX__Max_Plant_Count__c = -10);

        Test.startTest();
        try {
            CampGarden_TriggerHandler.restrictNegativeValues(new List<CAMPX__Garden__c>{garden});
            System.assert(false, 'Expected exception for negative values.');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('Plant Count fields must be greater than or equal to zero'), 'Error message should match.');
        }
        Test.stopTest();
    }

    @isTest
    static void testRestrictRange() {
        // Create test data
        CAMPX__Garden__c garden = new CAMPX__Garden__c(Name = 'Garden 1', CAMPX__Max_Plant_Count__c = 5, CAMPX__Minimum_Plant_Count__c = 10);

        Test.startTest();
        try {
            CampGarden_TriggerHandler.restrictRange(new List<CAMPX__Garden__c>{garden});
            System.assert(false, 'Expected exception for invalid range.');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('The Maximum Plant Count must be greater than or equal to the Minimum Plant Count'), 'Error message should match.');
        }
        Test.stopTest();
    }

    @isTest
    static void testSetGardenStatus() {
        // Create test data
        CAMPX__Garden__c garden = new CAMPX__Garden__c(Name = 'Garden 1', CAMPX__Capacity__c = 80, CAMPX__Total_Plant_Count__c = 50, CAMPX__Minimum_Plant_Count__c = 10, CAMPX__Health_Index__c = 75);

        Test.startTest();
        CampGarden_TriggerHandler.setGardenStatus(new List<CAMPX__Garden__c>{garden}, null);
        Test.stopTest();

        // Assert status is set
        System.assertEquals('Operational', garden.CAMPX__Status__c, 'Garden status should be set to Operational.');
    }
}