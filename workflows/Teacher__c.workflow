<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>City_1</fullName>
        <field>City__c</field>
        <literalValue>Lucknow</literalValue>
        <name>City 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>City_Jharkhand</fullName>
        <field>City__c</field>
        <literalValue>Ranchi</literalValue>
        <name>City Jharkhand</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Auto populate City</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Teacher__c.State__c</field>
            <operation>equals</operation>
            <value>Bihar</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>City Name</fullName>
        <actions>
            <name>City_1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Teacher__c.State__c</field>
            <operation>equals</operation>
            <value>Uttar Pradesh</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Jharkhand City</fullName>
        <actions>
            <name>City_Jharkhand</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Teacher__c.State__c</field>
            <operation>equals</operation>
            <value>Jharkhand</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
