/**
 * @description       :
 * @author            : Deepak
 * @Created on        : 09-20-2025
 * @Created by        : Deepak
 * @last modified on  : 09-20-2025
 * @last modified by  : Deepak
 * Modifications Log
 * Ver   Date         Author   Modification
 * 1.0   09-20-2025   Deepak   Initial Version
 **/
@istest
private class CaseEscalationReassignBatch_Test {
    
	/**
	 * @description
	 * @author Deepak | 09-20-2025
	 **/
	@istest
	static void Test_CaseEscalationReassignBatch() {
		List<Case> openCases = new List<Case>();
		for (integer i = 0; i < 100; i++) {
			openCases.add(new Case(Subject = 'Test Case ' + i, Description = 'Test Case Description'));
		}
		Database.insert(openCases);

		Test.StartTest();
		CaseEscalationReassignBatch caseReassignBatch = new CaseEscalationReassignBatch();
		Database.executeBatch(caseReassignBatch);
		Test.StopTest();
	}

	/**
	* @description 
	* @author Deepak | 09-20-2025 
	**/
	@istest
	static void Test_CaseEscalationReassignSchedule() {
		List<Case> openCases = new List<Case>();
		for (integer i = 0; i < 100; i++) {
			openCases.add(new Case(Subject = 'Test Case ' + i, Description = 'Test Case Description'));
		}
		Database.insert(openCases);

		CaseEscalationReassignBatch caseReassignBatch = new CaseEscalationReassignBatch();
		String sch = '20 30 8 10 2 ?';
		String jobID = System.schedule('Merge Job', sch, caseReassignBatch);
	}
}