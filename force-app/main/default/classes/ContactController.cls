public class ContactController {
    
    @AuraEnabled
    public static string createcontact(contact con){
        try{
            insert con;
            return 'Successfully created contact';
            
        }catch(DMLException ex){
            return 'unable to create contact' +ex.getMessage();
        }
        
        
    }
    
}