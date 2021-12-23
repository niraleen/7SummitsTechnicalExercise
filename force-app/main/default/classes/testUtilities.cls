@IsTest
global class testUtilities {

    @TestSetup
    public static void testSetup(){
        
        // Creating account test data
        List<Account> accList = new List<Account>();
        for(Integer i = 0 ; i < 100 ; i++){
            Account temp = new Account(Name = 'Test Acc ' + i);
            accList.add(temp);
        }
        insert accList;
        
        // Creating contact test data
        List<Contact> contactList = new List<Contact>();
        for(Integer i = 0 ; i < accList.size() ; i++){
            Contact temp = new Contact(LastName = 'Test Contact ' + i, AccountId = accList[i].Id);
            contactList.add(temp);
        }
        insert contactList;
        
        // Creating user test data
        List<User> usrList = new List<User>();
        Profile prof = [Select Id from Profile where Name = 'Customer Community Plus User' limit 1];   
        for(Integer i = 0; i < contactList.size(); i++){
            User temp = new User(alias = 'user' + i, email = 'TestUser' + i + '@gmail.com',
                 username = 'TestUser' + i + '@testorg.com', lastname = 'TestUser' + i, 
                 EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US',
                 TimeZoneSidKey = 'America/Denver', ProfileId = prof.Id, Street = '701 Wagner Drive', 
                 City = 'Fort Collins', State = 'CO', PostalCode = '80521', Country = 'United States', 
                 ContactId = contactList[i].Id);
                 usrList.add(temp);
        }
        insert usrList;
    }
}