<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>SFDC_Show_Stopper_Change_Request_Alert</fullName>
        <description>SFDC Show Stopper Change Request Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>SFDC_Admin_Team</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Admin_Team/Show_Stopper_Alert</template>
    </alerts>
</Workflow>
