@IsTest
public class UserContactTriggerHandlerTest {
    
    @IsTest
    static void TestUser() {
        
        //Creating a map to store users
        Map<Id, User> userMap = new Map<Id, User>();

        //step to fetch the current user Id
        User u = [select Id from user where Id=:userinfo.getUserId()];
        
        //running as current user
        System.runAs(u){ 
              
            //To fetch test data by invoking the testSetUp() method from testUtilities class
            testUtilities.testSetup();
            
            //Fetch a limit of 10 users based on criteria lastname = 'TestUser'
            List<user> usr = [Select Id, ContactId from User where lastname like '%TestUser%' limit 10];
            
            //For loop to run a loop on bove fetched users and update their street address
            for(User currUsr :usr ){
                User usrUpdtRec = new User(Id = currUsr.Id, Street = '1500 University Village');
                userMap.put(currUsr.contactId, usrUpdtRec);
            }

            //uppdate userMap
            //DML outside for loop to avoid crossing governor limits
            Update userMap.values();

            //Fetch contacts related to the above fetched users
            List<Contact> conList = [Select Id, MailingStreet from Contact where Id in :userMap.keySet()];
            
            //For loop to check every contact's street address against the user's street address
            //Using assertEquals() function to assert that the first two arguments are same. 
            //If both arguments have the different value, a fatal error is returned and code execution is halted
            for(Contact con : conList){
                System.assertEquals( userMap.get(con.Id).Street, con.MailingStreet,'Contact Street address same as user');
            }
        }
    }
}
