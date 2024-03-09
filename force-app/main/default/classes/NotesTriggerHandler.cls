public without sharing class NotesTriggerHandler {
    public NotesTriggerHandler() {

    }

    public static void updateNotes(List<ContentVersion>notesList){
        set<Id>docIds = new set<Id>();
        List<Opportunity>oppList = new List<Opportunity>();
        String notesData;
        Map<Id,String>noteMap = new Map<Id,String>();
        for(ContentVersion note:notesList){
            if(note.FileType=='SNOTE'){
                noteMap.put(note.contentDocumentId,note.VersionData.toString());
            }
        }

        List<ContentDocumentLink>docLinks = [Select Id,LinkedEntityId,ContentDocumentId from ContentDocumentLink
        where ContentDocumentId IN:noteMap.keyset()];
        for(ContentDocumentLink doc:docLinks){
            Id parentId = doc.LinkedEntityId;
            if(parentId.getSobjectType()==Opportunity.SObjectType){
                Opportunity opp = new Opportunity();
                opp.Id = parentId;
                opp.Strategic_Notes__c=noteMap.get(doc.contentDocumentId);
                oppList.add(opp);
            }
        }
        update oppList;
    }
}