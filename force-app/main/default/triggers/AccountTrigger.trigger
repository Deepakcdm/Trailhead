/**
 * @description       :
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             :
 * @last modified on  : 03-09-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 **/
trigger AccountTrigger on Account(before insert, before update) {
  if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
    AccountTriggerHandler.createAccounts(Trigger.new);
    AccountTriggerHandler.copyShippingAddress();
    AccountTriggerHandler.restrictDuplicateAccounts();
    AccountTriggerHandler.restrictNonAdminAccCreate();
    AccountTriggerHandler.restrictAccWithTwoContacts();
    AccountTriggerHandler.restrictAccWithContacts();
    // AccountTriggerHandler.restrictClosedOppUpdate();
    AccountTriggerHandler.restrictAccwithParentAcc();
    // AccountTriggerHandler.updateCaseofEmailOrigin();
  }

}
