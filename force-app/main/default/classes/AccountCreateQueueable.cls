/**
 * @description       : Sample Queueable Class to check the Max Limit of Queueable Jobs in Queued Status
 * @author            : Deepak
 * @group             :
 * @last modified on  : 01-04-2026
 * @last modified by  : Deepak
 **/
public with sharing class AccountCreateQueueable implements Queueable {
	List<Account> accounts = new List<Account>();
	List<Account> updatedAccounts = new List<Account>();
	Integer startIndex;
	Integer endIndex;

	/**
	 * @description : Sample method in Queueable to check the Max Limit of Queueable Jobs in Queued Status.
	 * @author Deepak | 08-09-2025
	 * @param List<Account> accounts
	 **/
	public AccountCreateQueueable(List<Account> accounts) {
		this.accounts = accounts;
		startIndex = 0;
		endIndex = Math.min(startIndex + 10, accounts.size());
	}

	public AccountCreateQueueable(List<Account> accounts, integer endNumber) {
		this.accounts = accounts;
		startIndex = endNumber;
		endIndex = Math.Min(endNumber + 10, accounts.size());
	}

	/**
	 * @description
	 * @author Deepak | 08-09-2025
	 * @param QueueableContext context
	 **/
	public void execute(QueueableContext context) {
		for (integer i = startIndex; i < endIndex; i++) {
			Account updatedAccount = accounts[i];
			updatedAccount.Active__c = 'Yes';
			updatedAccounts.add(updatedAccount);
		}

		if (!updatedAccounts.isEmpty()) {
			Database.update(updatedAccounts);
		}

		if (endIndex < accounts.size()) {
			System.enqueueJob(new AccountCreateQueueable(accounts, startIndex));
		}
	}
}