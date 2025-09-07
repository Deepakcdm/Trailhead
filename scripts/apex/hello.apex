/**
 * @description       : Anonymous Apex Snippet Changes
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 09-07-2025
 * @last modified by  : Deepak
**/
// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

string tempvar = 'Enter_your_name_here';
System.debug('Hello World!');
System.debug('My name is ' + tempvar);

// Scheduled class to be paused
Id apexClassIdToPause = '01p4u000000dVf7AAE';
List<AsyncApexJob> jobsToPause = [SELECT CronTriggerId FROM AsyncApexJob WHERE ApexClassId = :apexClassIdToPause];
for(AsyncApexJob jobToPause : jobsToPause) {
    System.pauseJobById(jobToPause.CronTriggerId);
}

//Query to Fetch the List of PermissionSet which has Read Access to any Field in Account Object
SELECT SobjectType, Field, PermissionsRead, Parent.Name,Parent.Label
FROM FieldPermissions
WHERE PermissionsRead = True and SobjectType='Account' and Parent.IsOwnedByProfile = true and Parent.isCustom=True

//Query to Fetch the List of Profiles which has access to the specific field
Select PermissionsRead, PermissionsEdit, Parent.Label, Parent.Id,Parent.Profile.Name
From FieldPermissions
Where Field = 'Account.Active__c' AND Parent.IsOwnedByProfile = TRUE 

//Query to Fetch the List of Permissionsets  which has access to the specific field
Select PermissionsRead, PermissionsEdit, Parent.Label
From FieldPermissions
Where Field = 'Account.Active__c' AND Parent.IsOwnedByProfile = FALSE 

System.debug(Account_Selector.getAccountOpportunities());