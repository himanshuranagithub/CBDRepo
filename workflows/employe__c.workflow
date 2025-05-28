<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>email_field_update</fullName>
        <description>email field update</description>
        <protected>false</protected>
        <recipients>
            <recipient>vikash.semykolon@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/abcds</template>
    </alerts>
    <alerts>
        <fullName>festival_wish</fullName>
        <description>festival wish</description>
        <protected>false</protected>
        <recipients>
            <recipient>vikash.semykolon@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Festival_wishes</template>
    </alerts>
    <fieldUpdates>
        <fullName>approved</fullName>
        <field>status__c</field>
        <literalValue>approved</literalValue>
        <name>approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>in_progres</fullName>
        <field>status__c</field>
        <literalValue>in progress</literalValue>
        <name>in progres</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>in_progreses</fullName>
        <field>status__c</field>
        <literalValue>in progress</literalValue>
        <name>in progreses</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>in_progress</fullName>
        <field>status__c</field>
        <literalValue>in progress</literalValue>
        <name>in progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>rejected</fullName>
        <field>status__c</field>
        <literalValue>rejeact</literalValue>
        <name>rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>email field</fullName>
        <actions>
            <name>email_field_update</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>employe__c.Email__c</field>
            <operation>notEqual</operation>
            <value>non</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
