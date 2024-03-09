public with sharing class WrapperController {
    public List<Case_Wrapper>openCaseWrapper{get;set;}
    public List<Attachment_Wrapper>attachWrapper{get;set;}
    public final case stdcase{get;set;}

    public WrapperController(ApexPages.StandardController Controller) {
        this.stdcase = (Case)Controller.getRecord();

        List<Case>caseList=[Select Id,CaseNumber,RecordTypeId,AccountId,Status,RecordType.Name,CreatedDate from Case Where AccountId =:stdCase.AccountId
        and Status!='Closed' order by CreatedDate DESC];

        if(!caseList.isEmpty()){
            openCaseWrapper = new List<Case_Wrapper>();
            for(Case c1:caseList){
                openCasewrapper.add(new Case_Wrapper(c1));
            }
        }

        List<Attachment>attachList=[Select Id,Name,CreatedDate,ParentId from Attachment where ParentId =:stdCase.Id];
        if(!attachList.isEmpty()){
            for(Attachment att1:attachList){
                attachwrapper.add(new Attachment_Wrapper(att1));
            }
        }
    }

    public List<Case_Wrapper>getOpenCases(){
        return openCaseWrapper;
    }

    public List<Attachment_Wrapper>getAttachments(){
        return attachwrapper;
    }

    /****** Case Warpper to get the List of Open Cases for the Account ***/
    public class case_Wrapper{
        public case openCaseList{get;set;}
        public boolean selected{get;set;}

        public case_Wrapper(Case openCase){
            openCaseList = opencase;
            selected = false;
        }
    }
    
    /*** Attachment wrapper to get the List of Attachments from the Chosen Closed Case ***/
    public class attachment_wrapper{
        public attachment attach{get;set;}
        public boolean choose{get;set;}

        public attachment_wrapper(Attachment att){
            attach = att;
            choose = false;
        }
    }
}