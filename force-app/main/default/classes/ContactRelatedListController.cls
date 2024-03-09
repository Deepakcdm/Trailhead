public class ContactRelatedListController {     

    public List<contact> contacts{get;set;} 

    public Account accounts {get;set;} 

    public Account acc {get;set;} 

     

    //Constructor 

    public ContactRelatedListController(ApexPages.StandardController controller) { 

        acc = (account)controller.getRecord();
        System.debug(acc);    
          }
          
        
        Public List<Contact>getContacts(){
          contacts = [SELECT id,Name, mobilephone, email FROM contact WHERE accountid = :acc.id ORDER BY Name]; 
          System.debug(contacts);
          return contacts;    

        }

}