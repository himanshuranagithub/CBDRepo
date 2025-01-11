/**
 * @description       : 
 * @author            : ritesh.kumar@kooziegroup.com
 * @group             : 
 * @last modified on  : 10-16-2024
 * @last modified by  : ritesh.kumar@kooziegroup.com
**/
public with sharing class AccountTriggerHandler extends TriggerHandler {
	private List<Account> newRecords;
	private Map<Id,Account> oldRecords;
	private static final Trigger_Settings__mdt triggerSetting = Trigger_Settings__mdt.getInstance('Account');

	public AccountTriggerHandler(String className){
		this.newRecords = (List<Account>) Trigger.new;
		this.oldRecords = (Map<Id,Account>) Trigger.oldMap; 
	} 

	public override void afterInsert() {
        //System.debug(LoggingLevel.INFO,'===== START afterInsert ====='+triggerSetting.Is_Active__c);
		Boolean pushData = false;
        if(triggerSetting.Is_Active__c == FALSE){
            return;
        }
        
		for(Account record : newRecords){
			WebsiteAccountPush.sendAccount(record.id, 'DML');
		}     
        //System.debug(LoggingLevel.INFO,'===== END afterInsert =====');
    } 

	public override void afterUpdate() {
        //System.debug(LoggingLevel.INFO,'===== START afterUpdate ====='+triggerSetting.Is_Active__c);
		Boolean pushData = false;
		Map<Id,String> accountInfo = new Map<Id,String>(); 
		
        if(triggerSetting.Is_Active__c == FALSE){
            return;
        }
        
        if(KoozieUtility.isRecursion == FALSE){
            return;
        }
        
		for(Account record : newRecords){
			pushData = getFieldDifference(record, oldRecords.get(record.Id)).size() > 0 ? true: false;
			if(pushData){
				WebsiteAccountPush.sendAccount(record.id, 'DML');
                KoozieUtility.isRecursion = FALSE;
			}

			if(record.Status__c == 'Inactive' && oldRecords.get(record.Id).Status__c != record.Status__c){
				//System.debug(LoggingLevel.INFO,'===== Inactive =====');
				accountInfo.put(record.Id,record.Status__c ); 
			} 
		} 

		if(!accountInfo.isEmpty()){
			//System.debug(LoggingLevel.INFO,'===== accountInfo ====='+accountInfo);
			Database.executeBatch(new UpdateContactStatus(accountInfo),2);
		}  
        //System.debug(LoggingLevel.INFO,'===== END afterInsert =====');
    } 

	public static Set<String> getFieldDifference(Account newAccount, Account oldAccount){ 

        Set<String> fieldDifferenc = new Set<String>();
 
        if(newAccount.Customer_Account_Number__c != oldAccount.Customer_Account_Number__c ){
            fieldDifferenc.add('Customer_Account_Number__c');
        }
        
        if(newAccount.Name != oldAccount.Name ){
            fieldDifferenc.add('Name');
        }
        
        if(newAccount.Account_Domain__c != oldAccount.Account_Domain__c ){
            fieldDifferenc.add('Account_Domain__c');
        } 
        
        if(newAccount.Koozie_Group_Tracker_Link__c != oldAccount.Koozie_Group_Tracker_Link__c ){
            fieldDifferenc.add('Koozie_Group_Tracker_Link__c');
        }
        
        if(newAccount.Primary_Team_Member2__c != oldAccount.Primary_Team_Member2__c ){
            fieldDifferenc.add('Primary_Team_Member2__c');
        }
        
        if(newAccount.Primary_Team_Member_Email__c != oldAccount.Primary_Team_Member_Email__c ){
            fieldDifferenc.add('Primary_Team_Member_Email__c');
        }
        
        if(newAccount.Primary_Sales_Rep_Region__c != oldAccount.Primary_Sales_Rep_Region__c ){
            fieldDifferenc.add('Primary_Sales_Rep_Region__c');
        }
        
        if(newAccount.BillingStreet != oldAccount.BillingStreet){
            fieldDifferenc.add('BillingStreet');
        }
                
        if(newAccount.BillingCity != oldAccount.BillingCity ){
            fieldDifferenc.add('BillingCity');
        }
        
        if(newAccount.BillingState != oldAccount.BillingState ){
            fieldDifferenc.add('BillingState');
        }
         
        if(newAccount.BillingCountry != oldAccount.BillingCountry ){
            fieldDifferenc.add('BillingCountry');
        }
        
        if(newAccount.BillingPostalCode != oldAccount.BillingPostalCode ){
            fieldDifferenc.add('BillingPostalCode');
        }

        if(newAccount.ShippingStreet != oldAccount.ShippingStreet ){
            fieldDifferenc.add('ShippingStreet');
        }

        if(newAccount.ShippingCity != oldAccount.ShippingCity ){
            fieldDifferenc.add('ShippingCity');
        }
        
        if(newAccount.ShippingState != oldAccount.ShippingState ){
            fieldDifferenc.add('ShippingState');
        }
        
        if(newAccount.ShippingCountry != oldAccount.ShippingCountry ){
            fieldDifferenc.add('ShippingCountry');
        }
                
        if(newAccount.ShippingPostalCode != oldAccount.ShippingPostalCode ){
            fieldDifferenc.add('ShippingPostalCode');
        }

		if(newAccount.PPAI_Number__c != oldAccount.PPAI_Number__c ){
            fieldDifferenc.add('PPAI_Number__c');
        }

		if(newAccount.ASI_Number__c != oldAccount.ASI_Number__c ){
            fieldDifferenc.add('ASI_Number__c');
        }

		if(newAccount.Status__c != oldAccount.Status__c ){
            fieldDifferenc.add('Status__c');
        }
        
        if(newAccount.Restrict_Pricing__c != oldAccount.Restrict_Pricing__c ){
            fieldDifferenc.add('Restrict_Pricing__c');
        }
       
        return fieldDifferenc; 
    }
}