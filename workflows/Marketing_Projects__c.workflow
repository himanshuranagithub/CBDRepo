<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alert_when_marketing_project_is_approved</fullName>
        <description>Alert: when marketing project is approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>amit.chandola@kooziegroup.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>elizabeth.mcentegart@kooziegroup.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Marketing_Projects/MP_STYBRB_APPROVED</template>
    </alerts>
    <alerts>
        <fullName>Designer_has_been_assigned</fullName>
        <description>Designer has been assigned</description>
        <protected>false</protected>
        <recipients>
            <field>Designer_Assigned__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Marketing_Projects/Project_Assigned_to_You</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_New_Project_Submitted</fullName>
        <ccEmails>trademarketingservices@bicgraphic.com</ccEmails>
        <description>Email Alert: New Project Submitted</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Marketing_Project_Submitted</template>
    </alerts>
    <alerts>
        <fullName>MP_is_recalled_by_creator</fullName>
        <ccEmails>SECreative@kooziegroup.com</ccEmails>
        <description>MP is recalled by creator</description>
        <protected>false</protected>
        <recipients>
            <recipient>lavanya.paidi@kooziegroup.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Recall_Notification_MP</template>
    </alerts>
    <alerts>
        <fullName>MP_request_is_rejected</fullName>
        <description>MP request is rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/MP_request_is_rejected</template>
    </alerts>
    <alerts>
        <fullName>Marketing_Project_Completed</fullName>
        <description>Marketing Project: Completed</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Marketing_Project_Completed</template>
    </alerts>
    <alerts>
        <fullName>Notification_to_Approver_for_Incoming_Requests</fullName>
        <description>Notification to Approver for Incoming Requests</description>
        <protected>false</protected>
        <recipients>
            <recipient>lavanya.paidi@kooziegroup.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/MP_request_is_sent_for_approval</template>
    </alerts>
    <alerts>
        <fullName>Please_approve_the_MP_request</fullName>
        <ccEmails>SECreative@kooziegroup.com</ccEmails>
        <description>Please approve the MP request</description>
        <protected>false</protected>
        <recipients>
            <recipient>lavanya.paidi@kooziegroup.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Marketing_Project_Approval_7_day_lead_time</template>
    </alerts>
    <alerts>
        <fullName>Project_Request_Approved_Lead_Time</fullName>
        <description>Project Request Approved (Lead Time)</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Project_7_Day_Lead_Time_Approved</template>
    </alerts>
    <alerts>
        <fullName>Project_Request_Rejected_Lead_Time</fullName>
        <description>Project Request Rejected (Lead Time)</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Project_7_Day_Lead_Time_Rejected</template>
    </alerts>
    <alerts>
        <fullName>SE_CREATIVE</fullName>
        <ccEmails>SECreative@kooziegroup.com</ccEmails>
        <description>SE CREATIVE</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Marketing_Projects/Custom_calendar_send_to_creative</template>
    </alerts>
    <alerts>
        <fullName>Self_Notification_that_record_is_gone_for_approval</fullName>
        <description>Self Notification that record is gone for approval</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/VSC_email</template>
    </alerts>
    <alerts>
        <fullName>Your_Project_Requires_Approval</fullName>
        <description>Your Project Requires Approval</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Marketing_Project_Requires_Approval_7_Day_Lead_Time</template>
    </alerts>
    <fieldUpdates>
        <fullName>AP_CHECKBOX</fullName>
        <field>InApprovalProcess__c</field>
        <literalValue>0</literalValue>
        <name>AP CHECKBOX</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AP_SB_PPT_OWNER</fullName>
        <field>OwnerId</field>
        <lookupValue>leslie.dawson@kooziegroup.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AP SB/PPT OWNER</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>In_Approval_Process</fullName>
        <description>Mark field checked for approval process</description>
        <field>InApprovalProcess__c</field>
        <literalValue>0</literalValue>
        <name>In Approval Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mark_project_approved</fullName>
        <field>Project_is_Approved__c</field>
        <literalValue>1</literalValue>
        <name>Mark project approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Marketing_Project_Record_Type_Switch</fullName>
        <description>From Create to Master Record Type</description>
        <field>RecordTypeId</field>
        <lookupValue>Standard_Project</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Marketing Project Record Type Switch</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Marketing_Project_Record_Type_Switch_2</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Newsletter_Marketing_Project</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Marketing Project Record Type Switch 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Not_In_Approval_Process</fullName>
        <field>InApprovalProcess__c</field>
        <literalValue>0</literalValue>
        <name>Not In Approval Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_Request_Rejected</fullName>
        <description>Project request rejected (lead time &lt; 7 days)</description>
        <field>Status__c</field>
        <literalValue>Created</literalValue>
        <name>Project Request Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submission_Due_Date</fullName>
        <field>Due_Date_Project_Submission__c</field>
        <formula>if( Due_Date_Project_Submission__c &gt; DATEVALUE(CreatedDate) + 5, Due_Date_Project_Submission__c, DATEVALUE(CreatedDate) + 5)</formula>
        <name>Submission Due Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submitted_to_Creative</fullName>
        <description>Field update if project requires lead time of less than 7 days</description>
        <field>Status__c</field>
        <literalValue>Submitted to Creative</literalValue>
        <name>Submitted to Creative</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Inapproval_Process</fullName>
        <field>InApprovalProcess__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Inapproval Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Submit_to_creative</fullName>
        <field>Status__c</field>
        <literalValue>Submitted to Creative</literalValue>
        <name>Update Submit to creative</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Marketing Project%3A New Designer Assigned</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Marketing_Projects__c.Designer_Assigned__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Email notification to designer that new project has been assigned</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>New Project Submitted</fullName>
        <actions>
            <name>Email_Alert_New_Project_Submitted</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Marketing_Projects__c.Status__c</field>
            <operation>equals</operation>
            <value>Submitted/Locked</value>
        </criteriaItems>
        <description>Email notification to Trade Marketing Services once a new project is submitted</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification - Designer Assigned</fullName>
        <actions>
            <name>Designer_has_been_assigned</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Email notification a Designer has been assigned</description>
        <formula>(ISNEW() &amp;&amp; NOT(ISBLANK(Designer_Assigned__c))) ||

ISCHANGED(Designer_Assigned__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Page Layout Change - Marketing Project</fullName>
        <actions>
            <name>Marketing_Project_Record_Type_Switch</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Marketing_Projects__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Created</value>
        </criteriaItems>
        <criteriaItems>
            <field>Marketing_Projects__c.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Custom Calendar</value>
        </criteriaItems>
        <description>Changes From Create to Master Page Layout</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Page Layout Change - Marketing Project%092</fullName>
        <actions>
            <name>Marketing_Project_Record_Type_Switch_2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Marketing_Projects__c.Product_Type__c</field>
            <operation>equals</operation>
            <value>Newsletter</value>
        </criteriaItems>
        <description>Changes From Create to Newsletter Page Layout</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Project%3A Completed</fullName>
        <actions>
            <name>Marketing_Project_Completed</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Marketing_Projects__c.Status__c</field>
            <operation>equals</operation>
            <value>Complete</value>
        </criteriaItems>
        <description>Email notification once project is completed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
