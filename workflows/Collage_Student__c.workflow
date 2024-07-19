<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>CollageStudentResult</fullName>
        <description>CollageStudentResult</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/StudentResult</template>
    </alerts>
    <alerts>
        <fullName>Test_Approval_Desc</fullName>
        <description>Test Approval Desc.</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Test_Text_Email_Template</template>
    </alerts>
    <alerts>
        <fullName>Welcome_email_for_collage_student</fullName>
        <description>Welcome email for collage student</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Test_Text_Email_Template</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approved_Scholorship</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approved Scholorship</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reject_Scholorship</fullName>
        <field>Status__c</field>
        <literalValue>Reject</literalValue>
        <name>Reject Scholorship</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Result_Update</fullName>
        <field>Result__c</field>
        <literalValue>Pass</literalValue>
        <name>Result Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Approve</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Status Approve</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_In_Progress</fullName>
        <field>Status__c</field>
        <literalValue>In-Progress</literalValue>
        <name>Status In Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Opened</fullName>
        <field>Status__c</field>
        <literalValue>Open</literalValue>
        <name>Status Opened</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Result Field Update</fullName>
        <actions>
            <name>Result_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Collage_Student__c.Total_Marks__c</field>
            <operation>greaterOrEqual</operation>
            <value>50</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Welcome email</fullName>
        <actions>
            <name>Welcome_email_for_collage_student</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Collage_Student__c.Email__c</field>
            <operation>notEqual</operation>
            <value>Null</value>
        </criteriaItems>
        <criteriaItems>
            <field>Collage_Student__c.Result__c</field>
            <operation>equals</operation>
            <value>Pass</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
