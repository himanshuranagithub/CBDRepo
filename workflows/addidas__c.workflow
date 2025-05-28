<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>fieldsupdate</fullName>
        <field>email__c</field>
        <name>fieldsupdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>email field not be equalor non</fullName>
        <actions>
            <name>fieldsupdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>addidas__c.email__c</field>
            <operation>notEqual</operation>
            <value>non</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
