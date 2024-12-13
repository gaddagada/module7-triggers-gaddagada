trigger OpportunityTrigger on Opportunity (before update, before delete) {
    if (Trigger.isBefore && Trigger.isUpdate){
            Set<Id> accountIds = new Set<Id>();
            for(Opportunity opp : Trigger.new){
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
                if(opp.Amount <= 5000 && opp.Amount != null){
                    opp.addError('Opportunity amount must be greater than 5000');
                }
            }
    
            
            Map<Id, Contact> accountToCeoContact = new Map<Id, Contact>();
            if (!accountIds.isEmpty()) {
                for (Contact con : [SELECT Id, AccountId FROM Contact WHERE Title = 'CEO' AND AccountId IN :accountIds]) {
                    accountToCeoContact.put(con.AccountId, con);
                }
            }
            
            for (Opportunity opp : Trigger.new) {
                if (opp.AccountId != null && accountToCeoContact.containsKey(opp.AccountId)) {
                    opp.Primary_Contact__c = accountToCeoContact.get(opp.AccountId).Id;
                }
            }
        }
        if(Trigger.isBefore && Trigger.isDelete){
            Set<Id> accountIdsToCheck = new Set<Id>();
            for(Opportunity opp : Trigger.old){
                if(opp.StageName == 'Closed Won'){
                    accountIdsToCheck.add(opp.AccountId);
                }
            }
            Map<Id,Account> accountMap = new Map<Id,Account>([SELECT Id, Industry FROM Account WHERE Id IN :accountIdsToCheck]);
            for(Opportunity opp : Trigger.old){
                if(opp.StageName == 'Closed Won' && accountMap.containsKey(opp.AccountId)){
                    Account relatedAccount = accountMap.get(opp.AccountId);
    
                    if(relatedAccount.Industry == 'Banking'){
                        opp.addError('Cannot delete closed opportunity for a banking account that is won');
                    }
                }
            }
        }
    }   

