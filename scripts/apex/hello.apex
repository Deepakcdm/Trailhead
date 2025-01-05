/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 01-05-2025
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
