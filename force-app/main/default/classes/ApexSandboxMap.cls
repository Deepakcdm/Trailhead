/**
 * @description       :
 * @author            : Deepak
 * @group             :
 * @last modified on  : 01-04-2026
 * @last modified by  : Deepak
 **/
public with sharing class ApexSandboxMap {
	/**
	 * @description
	 * @author Deepak | 10-20-2024
	 * @param Map<String String> employeeIdToEmail
	 * @param String employeeId
	 * @return String
	 **/
	public String employeeEmail(Map<String, String> employeeIdToEmail, String employeeId) {
		//code here
		string employeeEmail = employeeIdToEmail.containsKey(employeeId) ? employeeIdToEmail.get(employeeId) : 'info@apexsandbox.io';
		return employeeEmail;
	}

	/**
	 * @description
	 * @author Deepak | 10-20-2024
	 * @param List<Contact> contacts
	 * @return Map<String, String>
	 **/
	public Map<String, String> phonebook(List<Contact> contacts) {
		//code here
		Map<String, String> conPhoneMap = new Map<String, String>();
		for (Contact con : contacts) {
			if (!String.isBlank(con.Phone)) {
				conPhoneMap.put(con.Name, con.Phone);
			}
		}
		return conPhoneMap;
	}

	/**
	 * @description
	 * @author Deepak | 10-20-2024
	 * @param List<Account> accounts
	 * @return Map<String, Account>
	 **/
	public Map<String, Account> phoneToAccount(List<Account> accounts) {
		//code here
		Map<String, Account> accPhoneMap = new Map<String, Account>();
		for (Account acc : accounts) {
			if (!string.isBlank(acc.Phone)) {
				accPhoneMap.put(acc.Phone, acc);
			}
		}
		return accPhoneMap;
	}

	/**
	 * @description
	 * @author Deepak | 10-20-2024
	 * @param List<Account> accounts
	 * @return Map<String, Decimal>
	 **/
	public Map<String, Decimal> industrySummary(List<Account> accounts) {
		//code here
		Map<String, Decimal> accIndustryMap = new Map<String, Decimal>();
		for (Account acc : accounts) {
			if (acc.annualRevenue != null && !string.isBlank(acc.Industry)) {
				if (accIndustryMap.containsKey(acc.Industry)) {
					Decimal newRevenue = accIndustryMap.get(acc.Industry) + acc.annualRevenue;
					accIndustryMap.put(acc.Industry, newRevenue);
				} else {
					accIndustryMap.put(acc.Industry, acc.annualRevenue);
				}
			}
		}
		return accIndustryMap;
	}

	/**
	 * @description
	 * @author Deepak | 10-20-2024
	 * @param List<Case> cases
	 * @return Map<String, List<Case>>
	 **/
	public Map<String, List<Case>> casesByType(List<Case> cases) {
		//code here
		Map<String, List<Case>> casesByType = new Map<String, List<Case>>();
		for (Case newCase : Cases) {
			if (!string.isBlank(newCase.Type)) {
				if (casesByType.containsKey(newCase.Type)) {
					casesByType.get(newCase.Type).add(newCase);
				} else {
					casesByType.put(newCase.Type, new List<Case>{ NewCase });
				}
			}
		}
		return casesByType;
	}
}