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

trigger EBSContactTrigger on Contact (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    new SendContactToEBS('SendContactToEBS').debug(true).run();
}