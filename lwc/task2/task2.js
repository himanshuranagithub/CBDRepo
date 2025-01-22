import { LightningElement, wire, track } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import ACCOUNTS_MC from '@salesforce/messageChannel/AccountIdsMessageChannel__c';
import getAccounts from '@salesforce/apex/AccountTable.getAccounts';
import deleteAccounts from '@salesforce/apex/AccountTable.deleteAccounts';
import updateAccount from '@salesforce/apex/AccountTable.updateAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class task2 extends LightningElement {
    @track accounts = [];
    @track sortedBy;
    @track sortedDirection = 'asc';
    @track searchKey = '';
    @track selectedRows = [];
    @track isModalOpen = false;
    @track currentRecord = {};

    @wire(MessageContext)
    messageContext;

    @wire(getAccounts, { searchKey: '$searchKey' })
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
        } else if (error) {
            this.showToast('Error loading accounts', error.body.message, 'error');
        }
    }

    handleRowAction(event) {
        const actionName = event.target.dataset.action;
        const accountId = event.target.dataset.id;
        const row = this.accounts.find(acc => acc.Id === accountId);
        switch (actionName) {
            case 'update':
                this.currentRecord = { ...row };
                this.isModalOpen = true;
                break;
            case 'delete':
                this.handleDelete(accountId);
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