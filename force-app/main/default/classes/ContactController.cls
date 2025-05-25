/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 05-25-2025
 * @last modified by  : Deepak
**/
public class ContactController {
    
    // AuraEnabled annotation makes the method available to be called from Lightning Components
    @AuraEnabled
    public static string createcontact(contact con){
        try{
            // Attempt to insert the contact record
            insert con;
            // Return a success message if the insertion is successful
            return 'Successfully created contact';
            
        }catch(DMLException ex){
            // Catch any DMLException (Data Manipulation Language Exception) that occurs during the insertion
            // Return an error message with the exception details
            return 'unable to create contact' +ex.getMessage();
        }
        
        
    }
    
}