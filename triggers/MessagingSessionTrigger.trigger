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
trigger MessagingSessionTrigger on MessagingSession (after insert) {
    new MessagingSessionTriggerHandler('MessagingSessionTriggerHandler').debug(true).run();

}