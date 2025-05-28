// MainComponent.js
import { LightningElement,track } from 'lwc';
import fetchContactsByAccountId from '@salesforce/apex/Accountdetail.fetchContactsByAccountId';

export default class MainComponent extends LightningElement {
    contacts = [];
     selectedIds;
    showContactList = false;
    constructor() {
        super();
        // Add an event listener to capture the custom event
        this.addEventListener('fetchContactsEvent', this.handleFetchContacts);
        
    }

    handleFetchContacts(event) {
        const selectedIds = event.detail; 

        console.log('selectedIds:', selectedIds);

        fetchContactsByAccountId({ selectedIds: selectedIds })
            .then(result => {
                this.contacts = result;
                this.showContactList = true; 
            })
            .catch(error => {
                console.error('Error fetching contacts', error);
            });
    }
     @track showAccountList = true;
    @track showContactList = false;

    handleBackClick() {
        // Handle the back button click event from Contacts component
        // Toggle the visibility of components accordingly
        this.showAccountList = true;
        this.showContactList = false;
    }
}