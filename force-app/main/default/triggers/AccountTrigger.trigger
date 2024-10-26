trigger AccountTrigger on Account (before insert, after insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        for(Account acc : Trigger.new){
            if(String.isBlank(acc.Type)){
                acc.Type = 'Prospect';
            }    
            if(String.isNotBlank(acc.ShippingStreet)){
                acc.BillingStreet = acc.ShippingStreet;
            }
            if(String.isNotBlank(acc.ShippingCity)){
                acc.BillingCity = acc.ShippingCity;
            }
            if(String.isNotBlank(acc.ShippingState)){
                acc.BillingState = acc.ShippingState;
            }
            if(String.isNotBlank(acc.ShippingCountry)){
                acc.BillingCountry = acc.ShippingCountry;
            }
            if(String.isNotBlank(acc.ShippingPostalCode)){
                acc.BillingPostalCode = acc.ShippingPostalCode;    
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
        if (contactsToCreate.size() > 0) {
            insert contactsToCreate;
        }
    }
}