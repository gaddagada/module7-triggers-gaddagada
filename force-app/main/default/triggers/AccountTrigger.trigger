trigger AccountTrigger on Account (before insert, after insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        for(Account acc : Trigger.new){
            if(String.isBlank(acc.Type)){
                acc.Type = 'Prospect';
            }    
            if(!String.isBlank(acc.ShippingStreet) && !String.isBlank(acc.ShippingCity) && !String.isBlank(acc.ShippingState) && !String.isBlank(acc.ShippingPostalCode) && !String.isBlank(acc.ShippingCountry)){
                acc.BillingStreet = acc.ShippingStreet; 
                acc.BillingCity = acc.ShippingCity;
                acc.BillingState = acc.ShippingState;
                acc.BillingPostalCode = acc.ShippingPostalCode;
                acc.BillingCountry = acc.ShippingCountry;
            }
            
            if(String.isNotBlank(acc.Phone) && String.isNotBlank(acc.Fax) && String.isNotBlank(acc.Website)){
            acc.Rating = 'Hot';
            }
        }   
    }

    if(Trigger.isAfter && Trigger.isInsert){
        List<Contact> contactsToCreate = new List<Contact>();
        for(Account acc : Trigger.new) {
            Contact newContact = new Contact();
            newContact.LastName = 'DefaultContact';
            newContact.Email = 'default@email.com';
            newContact.AccountId = acc.Id;
            contactsToCreate.add(newContact);
        }
        if (!contactsToCreate.isEmpty()) {
            insert contactsToCreate;
        }
    }
}