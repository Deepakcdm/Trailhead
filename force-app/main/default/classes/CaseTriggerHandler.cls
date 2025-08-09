/**
 * @description       :
 * @author            : Deepak
 * @group             :
 * @last modified on  : 05-25-2025
 **/
public with sharing class CaseTriggerHandler {
	/**
	 * @description
	 * @author Deepak Kumar | 03-09-2024
	 **/
	public static void updateCaseofEmailOrigin(List<Case> newCases) {
		try {
			for (Case newCase : newCases) {
				if ('Email'.equalsIgnoreCase(newCase.Origin)) {
					newCase.Status = 'New';
					newCase.Priority = 'Medium';
				}
			}
		} catch (exception e) {
			system.debug(e.getMessage());
		}
	}

	/**
	* @description 
	* @author Deepak | 05-25-2025 
	**/
	public static void updateOwnerQueue(List<Case> newCases){
		Map<String,String> queueMap = new Map<String,String>();

		for(Group newGrp : [Select Id, DeveloperName from Group Where Type='Queue' and DeveloperName IN ('General_Support','Rapid_Response_Team')]){
			queueMap.put(newGrp.DeveloperName,newGrp.Id);
		}

		for(Case newCase: newCases){
			if('High'.equalsIgnoreCase(newCase.Priority)){
				newCase.ownerId=queueMap.get('Rapid_Response_Team');
		}else{
			newCase.ownerId=queueMap.get('General_Support');
		}
	}
}

  /**
  * @description 
  * @author Deepak | 05-25-2025 
  * @param List<Case> deletedCases 
  **/
  public static void restrictCaseDeletion(List<Case> deletedCases){
    for(Case deletedCase : deletedCases){
      if(!'Closed'.equalsIgnoreCase(deletedCase.Status)){
        deletedCase.addError('You cannot delete an open case');
      }
    }
  }
}