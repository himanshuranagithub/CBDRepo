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
</Workflow>
