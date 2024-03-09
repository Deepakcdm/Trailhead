public class ContactControllers {
    public Contact cont{get;set;}
    public string accountId{get;set;}
    
    public contactControllers(ApexPages.StandardsetController controller){
controller.setPageSize(10);
    }

}