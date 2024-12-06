// This is the trigger definition. The 'on Account' part means that this trigger will be associated with Account object
trigger TriggerAccountLesson on Account (before insert, before update, after insert, after update, after delete, after undelete) {
    
    // Before Insert Trigger Logic 
    // This part will be executed before a new Account is inserted into the database
    if(Trigger.isBefore && Trigger.isInsert){
        for(Account acc : Trigger.new){
            // Here you can add your custom logic
            // For example, let's ensure the Account Name is not null
            if(acc.Name == null){
                acc.Name = 'Default Account Name';
            }
        }
    }

    // Before Update Trigger Logic
    // This part will be executed before an existing Account record is updated
    if(Trigger.isBefore && Trigger.isUpdate){
        for(Account acc : Trigger.new){
            // Here you can add your custom logic
            // Let's ensure that the Account Name is not null when updating
            if(acc.Name == null){
                acc.Name = 'Default Account Name';
            }
        }
    }

    // After Insert Trigger Logic
    // This part will be executed after a new Account record is inserted into the database
    if(Trigger.isAfter && Trigger.isInsert){
        // You can reference the new Account records using Trigger.new
        // Let's just print the Ids of the new accounts
        for(Account acc : Trigger.new){
            System.debug('New Account Id: ' + acc.Id);
        }
    }

      // After Update Trigger Logic
    // This part will be executed after an existing Account record is updated
    if(Trigger.isAfter && Trigger.isUpdate){
        // You can reference the updated Account records using Trigger.new
        // Let's just print the Ids of the updated accounts
        for(Account acc : Trigger.new){
            System.debug('Updated Account Id: ' + acc.Id);
        }
    }
    
    // After Delete Trigger Logic
    // This part will be executed after an Account record is deleted
    if(Trigger.isAfter && Trigger.isDelete){
        // You can reference the deleted Account records using Trigger.old
        // Let's just print the Ids of the deleted accounts
        for(Account acc : Trigger.old){
            System.debug('Deleted Account Id: ' + acc.Id);
        }
    }

    // After Undelete Trigger Logic
    // This part will be executed after an Account record is undeleted
    if(Trigger.isAfter && Trigger.isUndelete){
        // You can reference the undeleted Account records using Trigger.new
        // Let's just print the Ids of the undeleted accounts
        for(Account acc : Trigger.new){
            System.debug('Undeleted Account Id: ' + acc.Id);
        }
    }
}