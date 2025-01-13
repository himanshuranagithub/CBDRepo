<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>Case Orange Tier II escalation</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.Tier_2_Escalated__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Team_Queue_List__c</field>
            <operation>equals</operation>
            <value>Orange Team</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case VOC Record type</fullName>
        <actions>
            <name>Case_RT_to_VOC</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Customer_To_Email__c</field>
            <operation>contains</operation>
            <value>voc@kooziegroup.com</value>
        </criteriaItems>
        <description>Change RT to VOC if email = voc@kooziegroup.com</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Formula field alternative</fullName>
        <actions>
            <name>CloseDateForAgeFormula</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ReOpenDateForAgeFormula</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Reminder Action - large orders</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.Next_Task_Reminder__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Send_reminder_for_large_orders</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.Next_Task_Reminder__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Updating Send Clarification Flag</fullName>
        <actions>
            <name>Update_Send_Clarification_Email_Flag</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>ISCHANGED(Clarification_Description__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Updating send email Flag</fullName>
        <actions>
            <name>Update_Send_Email_Flag_to_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>ISCHANGED(Proof_Description__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Who_Edited_Info_Case_Collaboratives</fullName>
        <actions>
            <name>StampTimeUsers</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>ISCHANGED( Case_Collaborative_Notes__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>name%2Etime%2Edate stamp</fullName>
        <actions>
            <name>Stamp_it</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>ISCHANGED(Description)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
