<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>New_Trade_Show_Notification</fullName>
        <ccEmails>tradeshowservices@bicgraphic.com</ccEmails>
        <description>New Trade Show Notification</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Trade_Show_Requested</template>
    </alerts>
    <alerts>
        <fullName>Notify_Campaign_Owner_to_Proceed_with_Trade_Show</fullName>
        <description>Notify Campaign Owner to Proceed with Trade Show</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Trade_Show_Notifications/Trade_Show_Approved</template>
    </alerts>
    <alerts>
        <fullName>Payment_Approved_Email</fullName>
        <description>Payment Approved Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Tradeshow_Payment_Apprpved</template>
    </alerts>
    <alerts>
        <fullName>TradeShow_VP_of_Sales_Approval</fullName>
        <description>TradeShow VP of Sales Approval</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Trade_Show_Notifications/Trade_Show_Approved</template>
    </alerts>
    <alerts>
        <fullName>Trade_Show_Approved</fullName>
        <description>Trade Show . - Approved</description>
        <protected>false</protected>
        <recipients>
            <field>Requested_By__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Trade_Show_Notifications/Trade_Show_Approved</template>
    </alerts>
    <alerts>
        <fullName>Trade_Show_Marketing_Approval_for_Payment</fullName>
        <description>Trade Show Marketing Approval for Payment</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Trade_Show_Notifications/Trade_Show_Payment_Approved</template>
    </alerts>
    <alerts>
        <fullName>Trade_Show_Marketing_Rejetion_for_Payment</fullName>
        <description>Trade Show Marketing Rejetion for Payment</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Trade_Show_Notifications/Trade_Show_Payment_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Trade_Show_Payment_Processed</fullName>
        <ccEmails>laurie.tenery@kooziegroup.com</ccEmails>
        <description>Trade Show Payment Processed</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Trade_Show_Notifications/Tradeshow_Payment_Sent</template>
    </alerts>
    <alerts>
        <fullName>Trade_Show_Rejected</fullName>
        <description>Trade Show - Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Trade_Show_Notifications/Trade_Show_Rejected</template>
    </alerts>
</Workflow>
