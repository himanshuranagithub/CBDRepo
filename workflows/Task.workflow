<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>Email Sub Type</fullName>
        <actions>
            <name>Activity_type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Task.TaskSubtype</field>
            <operation>equals</operation>
            <value>Email,List Email</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Subject for Activity Type</fullName>
        <actions>
            <name>Set_Subject_for_Task</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Task.Activity_Type__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Set Subject for Task on Mobil App by using the Activity Type Option</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Set Subject for Task</fullName>
        <actions>
            <name>Set_Subject_for_Task_1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Task.Type</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>IB</value>
        </criteriaItems>
        <description>Sets the subject for task based on the task type.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Summary to Short Description</fullName>
        <actions>
            <name>Set_Summary_to_Short_Description</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Task.Description</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>IB</value>
        </criteriaItems>
        <description>Grabs the Description for visibility in mobile view</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Task Type From Email</fullName>
        <actions>
            <name>Set_Task_Type_From_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Task.TaskSubtype</field>
            <operation>equals</operation>
            <value>Email</value>
        </criteriaItems>
        <description>Set task type when subject contains email.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Complete Date to Today</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Task.IsClosed</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Task.Status</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Task Type</fullName>
        <actions>
            <name>Update_Task_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Task.Activity_Type__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Task.Type</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Update the &quot;Task Type&quot; field based on activity type.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
