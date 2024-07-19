<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Traniestudentemailalert</fullName>
        <description>Tranie student email alert</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/send_email_to_client</template>
    </alerts>
    <alerts>
        <fullName>Welcome_Student_Email_Alert</fullName>
        <description>Welcome Student Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Employee_Welcome_Email</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approved_Record</fullName>
        <field>Scholarship_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approved Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Closed_Record</fullName>
        <field>Scholarship_Status__c</field>
        <literalValue>Closed</literalValue>
        <name>Closed Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Open_Record</fullName>
        <field>Scholarship_Status__c</field>
        <literalValue>Open</literalValue>
        <name>Open Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Process_locked</fullName>
        <field>Scholarship_Status__c</field>
        <literalValue>In-Progress</literalValue>
        <name>Process locked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reject_Record</fullName>
        <field>Scholarship_Status__c</field>
        <literalValue>Resject</literalValue>
        <name>Reject Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Capital_Of_MP</fullName>
        <field>Capital__c</field>
        <literalValue>Bhopal</literalValue>
        <name>Update Capital Of MP</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>MP capital Populate</fullName>
        <actions>
            <name>Update_Capital_Of_MP</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Trainee_Student__c.State__c</field>
            <operation>equals</operation>
            <value>MP</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
