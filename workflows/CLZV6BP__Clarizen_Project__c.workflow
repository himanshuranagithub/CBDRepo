<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>clz_4e363bd7-d0d5-45eb-a918-49e219c0bf62</fullName>
        <actions>
            <name>clz_5f27ac6a51fb4d289d9ea1b67f337e97</name>
            <type>OutboundMessage</type>
        </actions>
        <active>false</active>
        <formula>(CLZV6BP__Created_from_an_event__c=False)&amp;&amp;(CLZV6BP__CLZ_SYSID__c=null)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
