/**
 * @description       : 
 * @author            : Ritesh Kumar
 * @group             : 
 * @last modified on  : 01-02-2025
 * @last modified by  : Ritesh Kumar
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   01-02-2025   Ritesh Kumar   Initial Version
**/
public with sharing class MessagingSessionTriggerHandler  extends TriggerHandler{
   	private List<MessagingSession> newRecords;
	private Map<Id,MessagingSession> oldRecords;
	private static final Trigger_Settings__mdt triggerSetting = Trigger_Settings__mdt.getInstance('MessagingSession');

	public MessagingSessionTriggerHandler(String className){
		this.newRecords = (List<MessagingSession>) Trigger.new;
		this.oldRecords = (Map<Id,MessagingSession>) Trigger.oldMap;
	} 

	public override void afterInsert() {
        System.debug(LoggingLevel.INFO,'===== START afterInsert ====='+triggerSetting.Is_Active__c);
		Boolean pushData = false;
        if(triggerSetting.Is_Active__c == FALSE){
            return;
        }
        
		for(MessagingSession record : newRecords){ 
			System.debug(LoggingLevel.INFO,'===== START afterInsert ====='+record);
		}     
        System.debug(LoggingLevel.INFO,'===== END afterInsert =====');
    }
}