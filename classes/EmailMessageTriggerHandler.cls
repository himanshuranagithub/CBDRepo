public with sharing class EmailMessageTriggerHandler {
    public static void emailLinkCaseAssignment(List<EmailMessage> newEmailLinkList)
    {
        Boolean RunLogic = False;
        system.debug('emailLinkCaseAssignment called@@@@@@@'+newEmailLinkList);
        Set<Id> caseIds = new Set<Id>();
        Map<String,datetime> caseIDLinkDateMap = New Map<String,datetime>();
        String caseId = '';
        String emailMessageStatus = '';
        
        for ( EmailMessage el : newEmailLinkList )
        {
            caseId = el.ParentId;
            emailMessageStatus = el.Status;
            System.debug('====emailMessageStatus===='+emailMessageStatus);
            if ( el.ParentId != null && caseId.startsWith('500'))
            {
                caseIds.add(el.ParentId);
                caseIDLinkDateMap.put(el.ParentId , el.CreatedDate);
            }
        }
        
        Map<String, String> profileMap = new Map<String, String>();
        List<Profile> profileList = [SELECT Id, Name FROM Profile WHERE Name LIKE '%claim%'];
        
        for ( Profile pr : profileList )
        {
            profileMap.put(pr.Id, pr.Name);
        }
        
        List<Case> updateCaseList = new List<Case>();        
        Map<Id, Schema.RecordTypeInfo> caseRecordTypeMap = Case.sObjectType.getDescribe().getRecordTypeInfosById();
        List<Case> caseList = [SELECT Id, createddate,ReOpen_Date__c, Status, RecordTypeId, OwnerId, CreatedBy.ProfileId FROM Case WHERE Id =: caseIds];
        AssignmentRule AR = [SELECT Id FROM AssignmentRule WHERE SObjectType = 'Case' AND Active = True LIMIT 1];
        
        for ( Case cs : caseList )
        {
            Long caseCreatedTime = cs.createddate.getTime() ;
            Long currentDTLong = caseIDLinkDateMap.get(cs.id).getTime();
            Long milliseconds =  currentDTLong - caseCreatedTime;
            Long seconds = milliseconds / 1000;
            if(seconds > 4 ){
                RunLogic = true;
            }
            if(test.isRunningTest()){
                RunLogic = true;
            }
            if ( (RunLogic) && (caseRecordTypeMap.get(cs.RecordTypeId).getName().containsIgnoreCase('Clarification') 
                                && ( cs.Status != 'Closed' && cs.Status != 'Merged - Duplicate' && cs.Status != 'Merged' ) && emailMessageStatus != '5' && emailMessageStatus != '3' )) {
                                    cs.Status = 'Customer Response';
                                    system.debug('insdie if clarification type @@@@@@@@@@@@@');
                                    
                                    Database.DMLOptions dmlOpts = new Database.DMLOptions();
                                    dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.Id;
                                    
                                    cs.setOptions(dmlOpts);
                                    updateCaseList.add(cs);
                                }
            
            else if ( (RunLogic) && (!caseRecordTypeMap.get(cs.RecordTypeId).getName().containsIgnoreCase('Clarification') 
                                     && ( cs.Status == 'Closed' ) && emailMessageStatus != '5' && emailMessageStatus != '3')) {
                                         system.debug('insdie if  non clarification type @@@@@@@@@@@@@');
                                         cs.Status = 'Customer Response';
                                         cs.ReOpen_Date__c = DateTime.now();
                                         system.debug('insdie if  cs.Status @@@@@===> '+ cs.Status + 'insdie if  cs.Status @@@@@ cs.ReOpen_Date__c====> '+ cs.ReOpen_Date__c );
                                         system.debug('insdie if OwnerId @@@@@@@@@@@@@ ===> 11--->' + cs.OwnerId);
                                         
                                         /*Database.DMLOptions dmlOpts = new Database.DMLOptions();
                                         dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.Id;
                                         
                                         cs.setOptions(dmlOpts);*/
                                         updateCaseList.add(cs);
                                         system.debug('insdie if OwnerId @@@@@@@@@@@@@ ===> 22--->' + cs.OwnerId);
                                     }
            else if ( (RunLogic) && (!caseRecordTypeMap.get(cs.RecordTypeId).getName().containsIgnoreCase('Clarification') 
                                     && ( cs.Status != 'Closed' && cs.Status != 'Merged - Duplicate' &&  cs.Status != 'Merged') && emailMessageStatus != '5' && emailMessageStatus != '3')) {
                                         system.debug('if case is not clarification@@@@@@@@@@@');
                                         cs.Status = 'Customer Response';
                                         updateCaseList.add(cs);
                                         
                                     }
            
        }
        
        system.debug('updateCaseList@@@@@@@@@@'+updateCaseList);
        if(!updateCaseList.isempty() ){
            update updateCaseList;
            system.debug('insdie if OwnerId @@@@@@@@@@@@@ ===> 11--->' + updateCaseList[0].OwnerId);
        }
    }
    
}