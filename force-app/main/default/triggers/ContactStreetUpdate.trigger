trigger ContactStreetUpdate on User (after update) {
    
    if(trigger.isAfter){
        System.debug('I am an after trigger');
        UserContactTriggerHandler.afterUpdateHelper(trigger.oldMap, trigger.newMap);
    }
}