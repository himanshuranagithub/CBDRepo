/**
* @description       : 
* @author            : Ritesh Kumar
* @group             : 
* @last modified on  : 09-02-2024
* @last modified by  : ritesh.kumar@kooziegroup.com
* Ver   Date         Author         Modification
* 1.0   10-19-2023   Ritesh Kumar   
* 1.1   10-19-2023   Ritesh Kumar   JIRA SF-469 Code Line 
**/
@RestResource(urlMapping='/UpdateContact/*')
global class UpdateContact {
    
    @HttpPost
    global static void getContactRequest(){
        String recordID = '';
        UpdateContactRequest records = new UpdateContactRequest();
        Set<Contact> tempContact = new Set<Contact>();
        RestResponse response = RestContext.response;
        RestRequest request = RestContext.Request; 
        String Requestpayload = request.Requestbody.toString();
        String eventType = 'DML'; 
        Map<String,Callout_Handler_Setting__mdt> calloutSettingMap = new Map<String,Callout_Handler_Setting__mdt>() ; 
        
        for(Callout_Handler_Setting__mdt calloutSetting : [SELECT API_Method_Name__c,Is_Active__c FROM Callout_Handler_Setting__mdt]){
            calloutSettingMap.put(calloutSetting.API_Method_Name__c,calloutSetting); 
        }
        if(calloutSettingMap.containsKey('getContactRequest') && calloutSettingMap.get('getContactRequest').Is_Active__c){
            if(Requestpayload != '{}' && Requestpayload != null && Requestpayload!= ''){
                records =  UpdateContactRequest.parse(Requestpayload); 
            } 
        }
        
        //System.debug('===== UpdateContact records ======'+records);
        response.addHeader('Content-Type', 'application/json');  
        if(records != null && records.EventRequest != null ){
            try{
                Contact contactRecord = new Contact();
                
                if(String.isNotBlank(records.EventRequest.CustomerData.sf_Id)  && records.EventRequest.CustomerData.sf_Id != 'null'){
                    
                    contactRecord.Id = records.EventRequest.CustomerData.sf_Id;
                    
                } else{
                    if( String.isNotBlank(records.EventRequest.CustomerData.emailId) &&  String.isNotBlank(records.EventRequest.CustomerData.accountNumber)){
                        System.debug('====== UpdateContact records.EventRequest.CustomerData.Email ======='+records.EventRequest.CustomerData.emailId);
                        String contactId  = '';
                        contactId = ContactUtill.checkContact(records.EventRequest.CustomerData.emailId, records.EventRequest.CustomerData.accountNumber);
                        if(contactId != ''){
                            contactRecord.Id = contactId; 
                        }
                        eventType = ContactUtill.checkContact(records.EventRequest.CustomerData.emailId, records.EventRequest.CustomerData.accountNumber) != ''? 'DML' : 'DML';
                    } 
                } 
                
                
                
                if(String.isBlank(contactRecord.Id)){
                    contactRecord.RecordTypeId =  Schema.SObjectType.Contact.getRecordTypeInfosByName().get('CRM Contact').getRecordTypeId();
                }
                
                System.debug('========= UpdateContact records.EventRequest.CustomerData.web_Id ===='+records.EventRequest.CustomerData.web_Id);
                contactRecord.LastName = records.EventRequest.CustomerData.LastName;
                contactRecord.FirstName = records.EventRequest.CustomerData.FirstName ;
                contactRecord.User_Name__c = records.EventRequest.CustomerData.userName; 
                contactRecord.Email = records.EventRequest.CustomerData.emailId ;
                contactRecord.Web_Id__c = records.EventRequest.CustomerData.web_Id ;     
                contactRecord.Phone = records.EventRequest.CustomerData.primaryPhone;
                contactRecord.Contact_Type__c = records.EventRequest.CustomerData.contactType;
                contactRecord.User_Name__c = records.EventRequest.CustomerData.userName;
                contactRecord.MobilePhone = records.EventRequest.CustomerData.Mobile; 
                contactRecord.Industry_Type__c = records.EventRequest.CustomerData.industryType;
                 if(records.EventRequest.CustomerData.lastLoginDate != null){
                    contactRecord.Last_Login_Date__c = records.EventRequest.CustomerData.lastLoginDate;
                }
                contactRecord.Contact_Status__c = records.EventRequest.CustomerData.contactActiveStatus == TRUE ? 'Active':'Inactive';
                
                System.debug('========= UpdateContact rcontactRecord.Web_Id__c ===='+contactRecord.Web_Id__c);
                if(String.isNotBlank(records.EventRequest.CustomerData.accountNumber)){
                    contactRecord.AccountId = fetchAccountIdViaAccNumber(records.EventRequest.CustomerData.accountNumber);
                    /*Account [] accountRecord = [SELECT Id, Name FROM Account WHERE Customer_Account_Number__c =:records.EventRequest.CustomerData.accountNumber LIMIT 1 ];
                    if(accountRecord.size() > 0){
                        contactRecord.AccountId = accountRecord[0].Id ;
                    }*/
                }
                
                PickListValues pickListValue =  new PickListValues(); 
                pickListValue = fillPicklist(records);
                if(pickListValue != null){
                    if(String.isNotBlank(pickListValue.poConfirmation)){
                        contactRecord.PO_Confirmation__c = pickListValue.poConfirmation;
                    }
                    
                    if(String.isNotBlank(pickListValue.shipmentConfirmation)){
                        
                        contactRecord.Shipment_Confirmation__c = pickListValue.shipmentConfirmation;
                    } 
                    
                    
                    if(String.isNotBlank(pickListValue.proofConfirmation)){
                        
                        contactRecord.Proof_Confirmation__c = pickListValue.proofConfirmation;
                    } 
                    
                    if(String.isNotBlank(pickListValue.orderAcknowledgement)){
                        
                        contactRecord.Order_Acknowledgement__c = pickListValue.orderAcknowledgement;
                    }
                    
                    if(String.isNotBlank(pickListValue.clarificationConfirmation)){
                        
                        contactRecord.Clarification_Confirmation__c = pickListValue.clarificationConfirmation;
                    }
                    
                    if(String.isNotBlank(pickListValue.whenStatuschanges)){
                        
                        contactRecord.When_Status_changes__c = pickListValue.whenStatuschanges;
                    } 
                }
                
                
                if( records.EventRequest.CustomerData.AccountPreferences != null){
                    
                    
                   // if(records.EventRequest.CustomerData.AccountPreferences.size() > 0){
                        UpdateContactRequest.AccountPreferences preferences =records.EventRequest.CustomerData.AccountPreferences;
                     /*   for(UpdateContactRequest.AccountPreferences preferences : records.EventRequest.CustomerData.AccountPreferences){
                            Contact preferenceData = new Contact(); 
                            
                            
                            if(String.isNotBlank(preferences.firstName)){
                                preferenceData.FirstName = preferences.firstName;
                            }
                            
                            if(String.isNotBlank(preferences.lastName)){
                                preferenceData.LastName = preferences.lastName;
                            }
                            
                            if(String.isNotBlank(preferences.emailId)){
                                preferenceData.Email = preferences.emailId;
                            }
                            
                            if(String.isNotBlank(preferences.mobileNo)){
                                preferenceData.MobilePhone = preferences.mobileNo;
                            }
                            if(String.isNotBlank(records.EventRequest.CustomerData.accountNumber)){
                            	preferenceData.AccountId = fetchAccountIdViaAccNumber(records.EventRequest.CustomerData.accountNumber);
                            }*/
                            //if(contactRecord.Email == preferences.emailId ){
                                //System.debug('====== UpdateContact preferences IF ===='); 
                                contactRecord.Acc_PO_Contact__c = preferences.Acc_poConfirmation; 
                                contactRecord.Acc_Order_Acknowledgement__c = preferences.Acc_orderAcceptance;
                                contactRecord.Acc_Shipping_Contact__c = preferences.Acc_shipmentConfirmation; 
                                contactRecord.Acc_Proof_Confirmation__c = preferences.Acc_proofConfirmation;
                                contactRecord.Acc_Clarification_Confirmation__c = preferences.Acc_clarificationConfirmation;
                                //tempContact.add(contactRecord);
                                
                            /*}else{
                                System.debug('====== UpdateContact preferences ELSE ====');
                                if(String.isNotBlank(preferences.salesforceId)){
                                    //System.debug('====== CreateContacts preferences.salesforceId ===='+preferences.salesforceId);
                                    preferenceData.Id = preferences.salesforceId;
                                }
                                preferenceData.Acc_PO_Contact__c = preferences.Acc_poConfirmation; 
                                preferenceData.Acc_Order_Acknowledgement__c = preferences.Acc_orderAcceptance;
                                preferenceData.Acc_Shipping_Contact__c = preferences.Acc_shipmentConfirmation; 
                                preferenceData.Acc_Proof_Confirmation__c = preferences.Acc_proofConfirmation;
                                preferenceData.Acc_Clarification_Confirmation__c = preferences.Acc_clarificationConfirmation;
                                tempContact.add(preferenceData);
                            }*/
                            
                       // } 
                    //}  
                }  
                
                if(contactRecord != null){ // if(tempContact.size() > 0){
                    Database.UpsertResult results =  Database.Upsert(contactRecord,false);
                    recordID = results.getId();
                    if(results.isSuccess()){
                        if(tempContact.size() > 0){
                            List<Contact> preferenceList = new List<Contact>(); 
                            preferenceList.addAll(tempContact);
                            Database.Upsert(preferenceList,false);
                        }
                        
                        response.addHeader('Content-Type', 'application/json');                
                        response.statusCode = 200;   
                        
                        String responseData = ContactUtill.contactResponseForm(recordID, 'SUCCESS',eventType).getAsString();
                        //System.debug('====  UpdateContact responseData ==== '+responseData);
                        response.responseBody =  Blob.valueOf(responseData);
                    }else{
                        System.debug('====== Error ====');
                        response.addHeader('Content-Type', 'text/plain');
                        response.statusCode = 400;
                        response.responseBody =  Blob.valueOf(JSON.serialize(results.getErrors()));
                        ApexLogUtill.createApexLog('Website', Requestpayload, response.responseBody.toString(), recordID, 'Contact', JSON.serialize(results.getErrors()), response.statusCode);
                   }                      
                }
                
            }catch (DmlException crudException ){
                response.addHeader('Content-Type', 'text/plain');
                response.statusCode = 400;
                response.responseBody =  Blob.valueOf(JSON.serialize(crudException.getMessage()));
                ApexLogUtill.createApexLog('Website', Requestpayload, response.responseBody.toString(), recordID, 'Contact', crudException.getMessage(), response.statusCode);
            }
        }
    }
    @TestVisible
    private static id fetchAccountIdViaAccNumber(String accountNumber){
        return [SELECT Id, Name FROM Account WHERE Customer_Account_Number__c =:accountNumber LIMIT 1]?.Id;
    }
    public static PickListValues fillPicklist(UpdateContactRequest jsonData){
        
        //System.debug('====== PreferancesMethod ======'+jsonData.EventRequest.CustomerData.PreferanceTypes);
        PickListValues selectedValues = new PickListValues();
        UpdateContactRequest recordData = new UpdateContactRequest();
        
        if(jsonData != null){
            for(UpdateContactRequest.PreferanceTypes data : jsonData.EventRequest.CustomerData.PreferanceTypes){
                //System.debug('====== PreferanceTypes data ======'+data);
                for(UpdateContactRequest.Preferances  preferance: data.Preferances){
                    
                    //System.debug('====== Preferances preferanceName ======'+preferance.preferanceName);
                    if(preferance.preferanceName == 'PO Confirmation'){
                        for(UpdateContactRequest.PreferancesMethod value : preferance.PreferancesMethod){
                            if(value.Selected == 'true'){
                                selectedValues.poConfirmation = value.Value;
                                //System.debug('====== selectedValues.poConfirmation data ======'+selectedValues.poConfirmation);
                            }
                        }
                    }
                    
                    if(preferance.preferanceName == 'Order Acknowledgement'){
                        for(UpdateContactRequest.PreferancesMethod value : preferance.PreferancesMethod){
                            if(value.Selected == 'true'){
                                selectedValues.orderAcknowledgement = value.Value;
                                //System.debug('====== selectedValues.orderAcknowledgement data ======'+selectedValues.orderAcknowledgement);
                            }
                        }
                    }
                    
                    if(preferance.preferanceName == 'Shipment Confirmation'){
                        for(UpdateContactRequest.PreferancesMethod value : preferance.PreferancesMethod){
                            if(value.Selected == 'true'){
                                selectedValues.shipmentConfirmation = value.Value;
                                //System.debug('====== selectedValues.shipmentConfirmation data ======'+selectedValues.shipmentConfirmation);
                            }
                        }
                    }
                    
                    if(preferance.preferanceName == 'Proof Confirmation'){
                        for(UpdateContactRequest.PreferancesMethod value : preferance.PreferancesMethod){
                            if(value.Selected == 'true'){
                                selectedValues.proofConfirmation = value.Value;
                                //System.debug('====== selectedValues.proofConfirmation data ======'+selectedValues.proofConfirmation);
                            }
                        }
                    }
                    
                    if(preferance.preferanceName == 'When Status changes'){
                        for(UpdateContactRequest.PreferancesMethod value : preferance.PreferancesMethod){
                            if(value.Selected == 'true'){
                                selectedValues.whenStatuschanges = value.Value;
                                //System.debug('====== selectedValues.whenStatuschanges data ======'+selectedValues.whenStatuschanges);
                            }
                        }
                    }
                    
                    if(preferance.preferanceName == 'Clarification Confirmation'){
                        for(UpdateContactRequest.PreferancesMethod value : preferance.PreferancesMethod){
                            if(value.Selected == 'true'){
                                selectedValues.clarificationConfirmation = value.Value;
                                //System.debug('====== selectedValues.clarificationConfirmation data ======'+selectedValues.clarificationConfirmation);
                            }
                        }
                    } 
                } 
                
            }
        }
        
        return selectedValues;
    } 
    
    public class PickListValues {
        public String clarificationConfirmation = '';
        public String whenStatuschanges = '';
        public String proofConfirmation = '';
        public String shipmentConfirmation = '';
        public String orderAcknowledgement = '';
        public String poConfirmation = '';
    }
    
}