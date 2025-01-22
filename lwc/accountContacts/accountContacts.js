import { LightningElement, api, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import ACCOUNTS_MC from '@salesforce/messageChannel/AccountIdsMessageChannel__c';
import getRelatedContacts from '@salesforce/apex/AccountTable.getRelatedContacts';

export default class AccountContacts extends LightningElement {
    @api recordIds = [];
    accountContacts = [];

    @wire(MessageContext) messageContext;

    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    subscribeToMessageChannel() {
        this.subscription = subscribe(
            this.messageContext,
            ACCOUNTS_MC,
            (message) => this.handleMessage(message)
        );
    }

    handleMessage(message) {
        if (message && message.accountIds && message.accountIds.length > 0) {
            this.fetchRelatedContacts(message.accountIds);
        }
    }

    fetchRelatedContacts(accountIds) {
        getRelatedContacts({ accountIds: accountIds })
            .then(result => {
                console.log('Fetched related contacts:', result);
                this.accountContacts = result;
            })
            .catch(error => {
                console.error('Error fetching related contacts:', error);
            });
    }
}