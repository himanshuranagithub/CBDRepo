/**
 * @description       : 
 * @author            : ritesh.kumar@kooziegroup.com
 * @group             : 
 * @last modified on  : 09-18-2024
 * @last modified by  : ritesh.kumar@kooziegroup.com
**/
trigger AccountTrigger on Account (after insert, after update) {
    new AccountTriggerHandler('AccountTriggerHandler').debug(true).run();
}