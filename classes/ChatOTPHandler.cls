/**
 * @description       : 
 * @author            : Ritesh Kumar
 * @group             : 
 * @last modified on  : 11-20-2024
 * @last modified by  : Ritesh Kumar
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   11-20-2024   Ritesh Kumar   Initial Version
**/
public without sharing class ChatOTPHandler { 

     @AuraEnabled
    public static void sendOTP(String email){ 

        OTPService.sendOTP(email);

         
    }
}