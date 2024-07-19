<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Birthday_Wishes</fullName>
        <description>Birthday Wishes</description>
        <protected>false</protected>
        <recipients>
            <recipient>krishna.semykolon@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/HappyBirthday</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_on_Birthday</fullName>
        <description>Send Email on Birthday</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/HappyBirthday</template>
    </alerts>
    <alerts>
        <fullName>Welcome_Email</fullName>
        <description>Welcome Email</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Welcome</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approved1</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approved11</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Axpance_Approv</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Axpance Approv</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Closed1</fullName>
        <field>Status__c</field>
        <literalValue>Closed</literalValue>
        <name>Closed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Closed11</fullName>
        <field>Status__c</field>
        <literalValue>Closed</literalValue>
        <name>Closed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>In_Progress</fullName>
        <field>Status__c</field>
        <literalValue>In-Progress</literalValue>
        <name>In Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>In_Progress1</fullName>
        <field>Status__c</field>
        <literalValue>In-Progress</literalValue>
        <name>In Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>In_Progress11</fullName>
        <field>Status__c</field>
        <literalValue>In-Progress</literalValue>
        <name>In Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Inprogress</fullName>
        <field>Status__c</field>
        <literalValue>Closed</literalValue>
        <name>Inprogress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Open1</fullName>
        <field>Status__c</field>
        <literalValue>Open</literalValue>
        <name>Open</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Open11</fullName>
        <field>Status__c</field>
        <literalValue>Open</literalValue>
        <name>Open</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Recall_Travel_Expance_Status</fullName>
        <field>Status__c</field>
        <literalValue>Open</literalValue>
        <name>Recall Travel Expance Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reject1</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Reject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reject11</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Reject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Travel_Expanse_Approved_Data</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Travel Expanse Approved Data</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Travel_Expanse_Reject_Data</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Travel Expanse Reject Data</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_In_Progress</fullName>
        <field>Status__c</field>
        <literalValue>In-Progress</literalValue>
        <name>Update In-Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Update Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>TestWorkFlow</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Employee_Details__c.Travel_Expanse__c</field>
            <operation>greaterOrEqual</operation>
            <value>10000</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
