import { LightningElement, api, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import getRelatedContacts from '@salesforce/apex/AccountTable.getRelatedContacts';
import ACCOUNT_SELECTED_CHANNEL from '@salesforce/messageChannel/CounterMessageChannel__c';

export default class RelatedContactsTiles extends LightningElement {
    @api accountIds;
    relatedContactsByAccount = [];
    subscription = null; // Initialize subscription variable

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        this.subscribeToMessageChannel();
          this.fetchRelatedContacts();
    }

    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                ACCOUNT_SELECTED_CHANNEL,
                (message) => this.handleMessage(message)
            );
        }
    }
    
    handleMessage(message) {
        console.log('Received message:', message);
        this.accountIds = message.accountIds || []; // Ensure accountIds is initialized
        this.fetchRelatedContacts();
    }

    fetchRelatedContacts() {
        console.log('Fetching related contacts for accountIds:', this.accountIds);
        // if (this.accountIds.length === 0) {
        //     this.relatedContactsByAccount = []; // Clear existing data if no accountIds
        //     return;
        // }

        getRelatedContacts({ accountIds: this.accountIds })
            .then((result) => {
                console.log('Fetched related contacts:', result);
                this.relatedContactsByAccount = [];

                // Group contacts by account
                this.accountIds.forEach((accountId) => {
                    let accountContacts = {
                        accountId: accountId,
                        accountName: '',
                        contacts: []
                    };

                    // Find the account name
                    let account = result.find(acc => acc.AccountId === accountId);
                    if (account) {
                        accountContacts.accountName = account.AccountName;
                        accountContacts.contacts = account.Contacts;
                    }

                    this.relatedContactsByAccount.push(accountContacts);
                });
            })
            .catch((error) => {
                console.error('Error fetching related contacts:', error);
                // Handle errors gracefully (e.g., show error message to user)
            });
    }
    
    disconnectedCallback() {
        // Unsubscribe from message channel during cleanup
        if (this.subscription) {
            unsubscribe(this.subscription);
            this.subscription = null;
        }
    }
}