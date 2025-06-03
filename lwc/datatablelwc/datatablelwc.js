import { LightningElement, wire, track } from 'lwc';
import ShowListofAccount from '@salesforce/apex/Accountdetails.ShowListofAccount';
import { updateRecord, deleteRecord } from 'lightning/uiRecordApi';

const columns = [
    { label: 'Account Name', fieldName: 'Name', type: 'text', editable: true },
    { label: 'Phone', fieldName: 'Phone', type: 'phone', editable: true },
    { label: 'Rating', fieldName: 'Rating', type: 'picklist', editable: true },
    {
        type: 'action',
        typeAttributes: {
            rowActions: [
                { label: 'Update', name: 'update' },
                { label: 'Delete', name: 'delete' }
            ]
        }
    }
];

export default class datatablelwc extends LightningElement {
    @track accountList;
    columns = columns;
    error;
    draftValues = [];

    @wire(ShowListofAccount)
    wiredAccounts({ data, error }) {
        if (data) {
            this.accountList = data;
        }
        if (error) {
            this.error = error;
        }
    }

    saveHandleAction(event) {
        this.draftValues = event.detail.draftValues;

        const promises = this.draftValues.map(draft => {
            const recordInput = { fields: { Id: draft.Id } };
            Object.keys(draft).forEach(field => {
                if (field !== 'Id') {
                    recordInput.fields[field] = draft[field];
                }
            });
            return updateRecord(recordInput);
        });

        Promise.all(promises)
            .then(() => {
                this.refreshAccountList();
            })
            .catch(error => {
                console.error('Error updating account records:', error);
            });
    }

    refreshAccountList() {
        ShowListofAccount()
            .then(data => {
                this.accountList = data;
                this.draftValues = [];
            })
            .catch(error => {
                console.error('Error refreshing account list:', error);
            });
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        switch (actionName) {
            case 'update':
                this.updateAccount(row.Id);
                break;
            case 'delete':
                if (row && row.Id) {
                    this.deleteAccount(row.Id);
                }
                break;
            default:
                break;
        }
    }

    updateAccount(accountId) {
        const accountToUpdate = this.accountList.find(account => account.Id === accountId);
        const updatedFields = {};

        // Check if the Name field has been modified
        if (this.draftValues.some(draft => draft.Id === accountId && draft.Name !== accountToUpdate.Name)) {
            updatedFields.Name = accountToUpdate.Name;
        }

        // Check if the Rating field has been modified
        if (this.draftValues.some(draft => draft.Id === accountId && draft.Rating !== accountToUpdate.Rating)) {
            updatedFields.Rating = accountToUpdate.Rating;
        }

        // Check if the Phone field has been modified
        if (this.draftValues.some(draft => draft.Id === accountId && draft.Phone !== accountToUpdate.Phone)) {
            updatedFields.Phone = accountToUpdate.Phone;
        }

        if (Object.keys(updatedFields).length > 0) {
            // Perform the update action using the updatedFields object
            const recordInput = { fields: { Id: accountId, ...updatedFields } };

            updateRecord(recordInput)
                .then(() => {
                    this.refreshAccountList();
                })
                .catch(error => {
                    console.error('Error updating account record:', error);
                });
        }
    }

    deleteAccount(accountId) {
        deleteRecord(accountId)
            .then(() => {
                this.refreshAccountList();
            })
            .catch(error => {
                console.error('Error deleting account record:', error);
            });
    }
}