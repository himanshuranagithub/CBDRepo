/**
 * @description       : 
 * @author            : Ritesh Kumar
 * @group             : 
 * @last modified on  : 03-18-2024
 * @last modified by  : Ritesh Kumar
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   03-08-2024   Ritesh Kumar   Initial Version
**/

public with sharing class SendContactToEBS extends TriggerHandler {
    
    private List<Contact> newRecords;
    private List<Contact> oldRecords;
    private Map<Id, Contact> newRecordsMap;
    private Map<Id, Contact> oldRecordsMap; 
    private static final Trigger_Settings__mdt triggerSetting = Trigger_Settings__mdt.getInstance('Contact');
    private static final String WEBSITE ='WEBSITE';
    private static final String FINANCE_CONTACT = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Finance Contact').getRecordTypeId();
    private static final String INTEGRATION_SERVICE = System.Label.INTEGRATION_SERVICE;
    
    Enum DML_MODE {
        INSERT_DATA,
            UPDATE_DATA
            }
    //testing
    
    public SendContactToEBS(String className){
        this.newRecords = (List<Contact>) Trigger.new;
        this.oldRecords = (List<Contact>) Trigger.old;
        this.newRecordsMap = (Map<Id, Contact>) Trigger.newMap;
        this.oldRecordsMap = (Map<Id, Contact>) Trigger.oldMap; 
    } 
    
    public override void afterInsert() {
        System.debug(LoggingLevel.INFO,'===== SendContactToEBS: START afterInsert ====='+triggerSetting.Is_Active__c);
        if(triggerSetting.Is_Active__c == FALSE){
            return;
        } 
        
        if(KoozieUtility.isRecursion){
            for(Contact record : newRecords){
                if( record.Responsibility_Type__c != WEBSITE && record.RecordTypeId == FINANCE_CONTACT){
                    EBSContactCallout.sendContactData(record.Id,'CREATE');
                    KoozieUtility.isRecursion = FALSE;
                }
            }    
        }
        
    } 
    
    public override void afterUpdate(){
        System.debug(LoggingLevel.INFO,'===== SendContactToEBS : START afterUpdate ====='+triggerSetting.Is_Active__c);
        System.debug(LoggingLevel.INFO,'===== SendContactToEBS : Loop Count ====='+TriggerHandler.getLoopCount('SendContactToEBS'));
        
        if(triggerSetting.Is_Active__c == FALSE){
            return;
        } 
        
        if(KoozieUtility.isRecursion){
            for(Contact record : newRecords){
                System.debug(LoggingLevel.INFO,'===== SendContactToEBS : Responsibility_Type__c ====='+record.Responsibility_Type__c);
                System.debug(LoggingLevel.INFO,'===== SendContactToEBS : record.RecordTypeId ====='+record.RecordTypeId);
                System.debug(LoggingLevel.INFO,'===== SendContactToEBS : fieldChange ====='+fieldChange(record ,oldRecordsMap.get(record.Id)));
                System.debug(LoggingLevel.INFO,'===== SendContactToEBS : record OLD ====='+ oldRecordsMap.get(record.Id).Email);
                System.debug(LoggingLevel.INFO,'===== SendContactToEBS : record NEW ====='+ record.Email );
                if( record.Responsibility_Type__c != WEBSITE && record.RecordTypeId == FINANCE_CONTACT && fieldChange(record ,oldRecordsMap.get(record.Id))){ 
                    System.debug(LoggingLevel.INFO,'===== SendContactToEBS : In side if =====');
                    if( record.Contact_ID__c != null){ 
                        //EBSContactDML.getJsonString(record.Id, 'UPDATE');
                        EBSContactCallout.sendContactData(record.Id,'UPDATE');
                    }else{ 
                        //EBSContactDML.getJsonString(record.Id, 'CREATE');
                        EBSContactCallout.sendContactData(record.Id,'CREATE');
                    }
                    
                    KoozieUtility.isRecursion = FALSE;
                }
            } 
            
        } 
    }
    
    private static Boolean fieldChange(Contact newVersion ,Contact oldVersion){
        System.debug(LoggingLevel.INFO,'===== SendContactToEBS :fieldChange =====');
        if(newVersion.Email != oldVersion.Email){
            return TRUE;
        }
        
        if(newVersion.Other_Email__c != oldVersion.Other_Email__c){
            return TRUE;
        }
        
        if(newVersion.Phone != oldVersion.Phone){
            return TRUE;
        }
        
        if(newVersion.OtherPhone != oldVersion.OtherPhone){
            return TRUE;
        }
        
        if(newVersion.Fax != oldVersion.Fax){
            return TRUE;
        }
        
        if(newVersion.Primary_Responsibility_Flag__c != oldVersion.Primary_Responsibility_Flag__c){
            return TRUE;
        }
        
        if(newVersion.Responsibility_Type__c != oldVersion.Responsibility_Type__c){
            return TRUE;
        }
        
        if(newVersion.Contact_Status__c != oldVersion.Contact_Status__c){
            return TRUE;
        }
        
        return FALSE;
    }
}