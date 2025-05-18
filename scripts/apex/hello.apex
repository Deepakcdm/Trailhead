/**
 * @description       : Anonymous Apex Snippet Changes
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 05-18-2025
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


// Query to get Permission Sets with Read access to the 'Rating' field on the 'Account' object
List<String> permissionSetNames = new List<String>();
List<PermissionSet> pmsets = [Select Id,Label,Name from PermissionSet Where Id IN (Select ParentId from FieldPermissions where SobjectType='Account' AND 
Field='Account.Rating' AND PermissionsRead=TRUE)];

for(Permissionset pmset: pmsets){
        permissionSetNames.add(pmset.Label);
}

System.debug('The Permission set Names --->'+ permissionsetNames);

// Query to get Permission Sets with Edit access to the 'Rating' field on the 'Account' object
List<String> permissionSetNames = new List<String>();
List<PermissionSet> pmsets = [Select Id,Label,Name from PermissionSet Where Id IN (Select ParentId from FieldPermissions where SobjectType='Account' AND 
Field='Account.Rating' AND PermissionsEdit=TRUE)];

for(Permissionset pmset: pmsets){
        permissionSetNames.add(pmset.Label);
}

System.debug('The Permission set Names --->'+ permissionsetNames);

