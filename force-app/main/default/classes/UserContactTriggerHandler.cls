/*  Exercise:      7Summits Technical Challenge
    Developer:     Niralee Nanda
    Date:          12/22/2020
    Apex Class:    Handler Class to update a Contact's mailing address 
                   whenever the related User record changes their street address
    Handler Class: UserContactTriggerHandler */

public with sharing class UserContactTriggerHandler {

    public static void afterUpdateHelper( Map<Id,User> oldUserMap, Map<Id,User> newUserMap ){  
        //Creating a new list of Contacts
        List<Contact> conItemList = new List<Contact>();
            
        //Using a for loop for checking all the new map values
        for( User usrCon :newUserMap.values()){
                
            //if-condition to check whether the street address on the old user record 
            //is not same as the new user's street address 
            if( usrCon.Street!= oldUserMap.get(usrCon.Id).Street && usrCon.ContactId != null ){
                Contact con = new Contact( Id = usrCon.ContactId, MailingStreet = usrCon.Street );
                conItemList.add( con );
            }
        }
            
            //if-condition to check if the list is empty
            //update list if true
            if( !conItemList.isEmpty()){ 
                update conItemList;
            }
    }
}