import { LightningElement, wire, track } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import ACCOUNTS_MC from '@salesforce/messageChannel/AccountIdsMessageChannel__c';
import getAccounts from '@salesforce/apex/AccountTable.getAccounts';
import deleteAccounts from '@salesforce/apex/AccountTable.deleteAccounts';
import updateAccount from '@salesforce/apex/AccountTable.updateAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

// Define actions for the data table
const actions = [
    { label: 'Update', name: 'update' },
    { label: 'Delete', name: 'delete' }
];

// Define columns with inline editing enabled
const columns = [
    { label: 'Name', fieldName: 'Name', editable: true },
    { label: 'Industry', fieldName: 'Industry', editable: true },
    { label: 'Phone', fieldName: 'Phone', type: 'phone', editable: true },
    { label: 'Website', fieldName: 'Website', type: 'url', editable: true },
    {
        type: 'action',
        typeAttributes: { rowActions: actions }
    }
];

export default class Task1 extends LightningElement {
    @track columns = columns;
    @track sortedBy;
    @track sortedDirection = 'asc';
    @track searchKey = '';
    @track selectedRows = [];
    @track isModalOpen = false;
    @track currentRecord = {};
    @track accounts = [];
    @track draftValues = []; // To hold draft values for inline editing
    wiredAccountsResult; // Track wired result for refresh

    @wire(MessageContext)
    messageContext;

    @wire(getAccounts, { searchKey: '$searchKey' })
    wiredAccounts(result) {
        this.wiredAccountsResult = result;
        const { error, data } = result;
        if (data) {
            this.accounts = data;
        } else if (error) {
            this.showToast('Error loading accounts', error.body.message, 'error');
        }
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'update':
                this.currentRecord = { ...row };
                this.isModalOpen = true;
                break;
            case 'delete':
                this.handleDelete(row.Id);
                break;
            default:
        }
    }

    handleSort(event) {
        this.sortedBy = event.detail.fieldName;
        this.sortedDirection = event.detail.sortDirection;
        this.sortData(this.sortedBy, this.sortedDirection);
    }

    sortData(fieldname, direction) {
        let parseData = JSON.parse(JSON.stringify(this.accounts));
        let keyValue = (a) => {
            return a[fieldname] ? a[fieldname] : '';
        };
        let isReverse = direction === 'asc' ? 1 : -1;
        parseData.sort((x, y) => {
            x = keyValue(x);
            y = keyValue(y);
            return isReverse * ((x > y) - (y > x));
        });
        this.accounts = parseData;
    }

    handleSearchKeyChange(event) {
        this.searchKey = event.target.value;
    }

    handleRowSelection(event) {
        this.selectedRows = event.detail.selectedRows;
    }

    handleDelete(accountId) {
        deleteAccounts({ accountIds: [accountId] })
            .then(() => {
                this.showToast('Success', 'Account deleted', 'success');
                return refreshApex(this.wiredAccountsResult);
            })
            .catch(error => {
                this.showToast('Error deleting account', error.body.message, 'error');
            });
    }

    handleDeleteSelected() {
        const selectedIds = this.selectedRows.map(row => row.Id);
        deleteAccounts({ accountIds: selectedIds })
            .then(() => {
                this.showToast('Success', 'Selected accounts deleted', 'success');
                return refreshApex(this.wiredAccountsResult);
            })
            .catch(error => {
                this.showToast('Error deleting selected accounts', error.body.message, 'error');
            });
    }

    handleModalClose() {
        this.isModalOpen = false;
    }

    handleFieldChange(event) {
        const field = event.target.name;
        this.currentRecord[field] = event.target.value;
    }

    handleSave() {
        updateAccount({ account: this.currentRecord })
            .then(() => {
                this.showToast('Success', 'Account updated', 'success');
                this.isModalOpen = false;
                this.draftValues = []; // Clear draft values if updating from inline edit
                // Refresh data after save
                return refreshApex(this.wiredAccountsResult);
            })
            .catch(error => {
                this.showToast('Error updating account', error.body.message, 'error');
            });
    }

    handlePublishAccountIds() {
        const accountIds = this.selectedRows.map(row => row.Id);
        const payload = { accountIds };
        publish(this.messageContext, ACCOUNTS_MC, payload);
    }

    handleSaveDraft(event) {
        // Get the draft values from the event
        const draftValues = event.detail.draftValues;

        // Ensure draftValues is not null or empty
        if (draftValues.length === 0) {
            this.showToast('Error', 'No changes to save', 'error');
            return;
        }

        // Assume that each draft value represents a separate record to update
        const accountToUpdate = draftValues[0];

        // Directly set this as the current record to reuse the existing update logic
        this.currentRecord = { ...accountToUpdate };

        // Call the existing handleSave method to update the record
        this.handleSave();
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: variant,
            })
        );
    }
}