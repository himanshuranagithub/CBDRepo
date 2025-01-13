<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Account_on_Credit_Hold</fullName>
        <description>Account on Credit Hold</description>
        <protected>false</protected>
        <recipients>
            <recipient>Account Manager</recipient>
            <type>accountTeam</type>
        </recipients>
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
            <recipient>Regional Manager</recipient>
            <type>accountTeam</type>
        </recipients>
        <recipients>
            <recipient>Sales Rep</recipient>
            <type>accountTeam</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Account_Credit_Hold</template>
    </alerts>
</Workflow>
