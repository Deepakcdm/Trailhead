public class vfValidationController{
    private Account acc{get;set;}
    private String name{get;set;}
    private string email{get;set;}
    private string sla{get;set;}
    public vfValidationController(ApexPages.StandardController stdController){
        this.acc = (Account)stdController.getRecord();
    }
    public void save1(){
        insert acc;

        }
}