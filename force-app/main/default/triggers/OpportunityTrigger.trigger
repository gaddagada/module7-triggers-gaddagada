trigger OpportunityTrigger on Opportunity (before update, before delete) {
    if (Trigger.isBefore){
        if(Trigger.isUpdate){
            Set<Id> accountIds = new Set<Id>();
            for(Opportunity opp : Trigger.new){
                if(opp.Amount < 5000) {
                    opp.addError('Opportunity amount must be greater than 5000');
                }
                accountIds.add(opp.AccountId);
            }
    
            List<Contact> contList = [SELECT Id, Name, AccountId, Title FROM Contact WHERE AccountId IN :accountIds AND Title = 'CEO'];
            for(Opportunity opp : Trigger.new){
                for(Contact c : contList){
                    if(c.AccountId == opp.AccountId){
                        opp.Primary_Contact__c = c.Id;
                        break;
                    }
                }
            }
        }  

        else if (Trigger.isDelete){
            Set<Id> accIds = new Set<Id>();
            for (Opportunity oApp : Trigger.old){
                if(String.isNotBlank(opp.AccountId)){
                    accIds.add(opp.AccountId);
                }
            }
            Map<Id, Account> idToAccountMap = new Map<Id, Account>([SELECT Id, Industry FROM Account WHERE Id IN :accIds]);
            for (Opportunity opp : Trigger.old){
                If(opp.StageName == 'Closed Won' && idToAccountMap.get(opp.AccountId).Industry == 'Banking'){
                    opp.addError('Cannot delete closed opportunity for a banking account that is won');
                }
            }
        }
    }

}