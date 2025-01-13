<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>New Trade Show Notification</fullName>
        <actions>
            <name>New_Trade_Show_Notification</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Campaign.RecordTypeId</field>
            <operation>equals</operation>
            <value>Trade Show or EME/Event</value>
        </criteriaItems>
        <criteriaItems>
            <field>Campaign.Status</field>
            <operation>equals</operation>
            <value>Request Payment</value>
        </criteriaItems>
        <criteriaItems>
            <field>Campaign.Approved_By_Manager__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Email alert if new Trade Show requests payment</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Payment Approved</fullName>
        <actions>
            <name>Payment_Approved_Email</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Payment_Approved</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND (2 Or 3)</booleanFilter>
        <criteriaItems>
            <field>Campaign.Status</field>
            <operation>equals</operation>
            <value>Payment Processed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Campaign.LastModifiedById</field>
            <operation>equals</operation>
            <value>Tiffany Marmo</value>
        </criteriaItems>
        <criteriaItems>
            <field>Campaign.LastModifiedById</field>
            <operation>equals</operation>
            <value>Victor Rosado</value>
        </criteriaItems>
        <description>Field update once path stage changes to &quot;Payment Processed&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Payment Method is AMEX card</fullName>
        <actions>
            <name>Update_Payment_Approved_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Campaign.Payment_Method__c</field>
            <operation>equals</operation>
            <value>Paid on AMEX</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
