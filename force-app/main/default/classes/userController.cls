public with sharing class userController

{

       //This variable hold the id of  user which is selected by enduser from picklist

        public String selecteduserId {set;get;}

      

      //This var hold List of user

      public List<SelectOption> getListOfUser()

    {

               List<User> Users = [select id ,Username,name from user] ;

               List<SelectOption> UserOptionList = new List<SelectOption>();

               UserOptionList .add(new SelectOption( ' ' ,'---Select---'));

               for(User u : Users )
               {
                          UserOptionList .add(new SelectOption(u.Id , u.Name));
               }

              return UserOptionList ;

    }

 

  public userController()

  {

                    selecteduserId ='';

  }

 

}