<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Assign_to_AE</fullName>
        <description>Assign to AE</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Return_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Calendar_Oppty_Assigned_to_AE</template>
    </alerts>
    <alerts>
        <fullName>Assign_to_Estimator</fullName>
        <description>Assign to Estimator</description>
        <protected>false</protected>
        <recipients>
            <recipient>Estimator #1</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <recipient>Estimator #2</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <recipient>Estimator #3</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Calendar_Oppty_Assigned_to_Estimator</template>
    </alerts>
    <alerts>
        <fullName>CSR_created_Opps</fullName>
        <description>CSR created Opps</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/CSR_Opportunities</template>
    </alerts>
    <alerts>
        <fullName>Close_date_Expired</fullName>
        <description>Close date Expired</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opportunity_Template_1689939928691</template>
    </alerts>
    <alerts>
        <fullName>Close_date_is_today</fullName>
        <description>Close date is today</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Action_Req_close_date_today</template>
    </alerts>
    <alerts>
        <fullName>New_Mktg_Halo_Oppty_created</fullName>
        <ccEmails>remove_test_halosalesteam@kooziegroup.com, akashdeep.sharma@kooziegroup.com</ccEmails>
        <description>New Mktg Halo Oppty created</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Mktg_Opportunity_Template_2_1678674336201</template>
    </alerts>
    <alerts>
        <fullName>New_Mktg_Oppty_created</fullName>
        <ccEmails>akashdeep.sharma@kooziegroup.com</ccEmails>
        <description>New Mktg Oppty created</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Mktg_Opportunity_Template_2_1678674336201</template>
    </alerts>
    <alerts>
        <fullName>New_Special_Pricing_Request</fullName>
        <description>New Special Pricing Request</description>
        <protected>false</protected>
        <recipients>
            <recipient>Quoting_Manager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>amit.chandola@kooziegroup.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Opportunity_Approvals/Special_Price_Approval_Request_Notice</template>
    </alerts>
    <alerts>
        <fullName>Opportunities_over_5k</fullName>
        <description>Opportunities over $5k</description>
        <protected>false</protected>
        <recipients>
            <recipient>Field Sales</recipient>
            <type>accountTeam</type>
        </recipients>
        <recipients>
            <recipient>Inside Sales</recipient>
            <type>accountTeam</type>
        </recipients>
        <recipients>
            <recipient>National Sales</recipient>
            <type>accountTeam</type>
        </recipients>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opportunity_Greater_than_5k</template>
    </alerts>
    <alerts>
        <fullName>Opportunity_Expired</fullName>
        <description>Opportunity Expired</description>
        <protected>false</protected>
        <recipients>
            <recipient>National Sales</recipient>
            <type>accountTeam</type>
        </recipients>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/OpptyExpired</template>
    </alerts>
    <alerts>
        <fullName>Opportunity_is_expiring</fullName>
        <description>Opportunity is expiring</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Alert_Opportunity_Template_1690284663194</template>
    </alerts>
    <alerts>
        <fullName>Opportunity_is_expiring_tommorow</fullName>
        <description>Opportunity is expiring after 2 days</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Action_Required_Close_Date_Approaching</template>
    </alerts>
    <alerts>
        <fullName>Rejection_Notice</fullName>
        <description>Rejection Notice</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Opportunity_Approvals/Special_Price_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Special_Price_Approval_Notice</fullName>
        <description>Special Price Approval Notice</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Opportunity_Approvals/Special_Price_Approved</template>
    </alerts>
    <alerts>
        <fullName>Special_Price_Rejection_Notice</fullName>
        <description>Special Price Rejection Notice</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Opportunity_Approvals/Special_Price_Rejected</template>
    </alerts>
</Workflow>
