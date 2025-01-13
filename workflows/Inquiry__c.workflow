<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>Creates a Follow up Task in Account</fullName>
        <actions>
            <name>Follow_Up_Required</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Inquiry__c.Follow_Up_Required__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
