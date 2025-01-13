<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>Last Email Replied</fullName>
        <actions>
            <name>Update_Last_Replied_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>EmailMessage.Status</field>
            <operation>equals</operation>
            <value>Read,Replied</value>
        </criteriaItems>
        <description>This rule will populate the last replied email field on case. (Replied or Read) It is using the Email Message object to obtain the information.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
