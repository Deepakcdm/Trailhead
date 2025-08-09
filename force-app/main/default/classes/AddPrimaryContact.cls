public with sharing class AddPrimaryContact implements Queueable {
  public Contact cont;
  public String accState;

  public AddPrimaryContact(Contact con, String state) {
    cont = con;
    accState = state;
  }

  /* Method Name : Execute */
  public void execute(QueueableContext context) {
    List<Contact> contactList = new List<Contact>();
    for (Account acct : [
      SELECT Id, BillingState
      FROM Account
      WHERE BillingState = :accState
    ]) {
      Contact cons = cont.Clone();
      cons.accountId = acct.Id;
      contactList.add(cons);
    }
    Database.insert(contactList, false);
  }
}