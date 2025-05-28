import { LightningElement, wire } from 'lwc';
import { getListUi } from 'lightning/uiListApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const COLUMNS = [
    { type: 'checkbox', fieldName: 'selected', label: 'Select' },
    { label: 'Account Name', fieldName: 'Name', type: 'text' },
    { label: 'Rating', fieldName: 'Rating', type: 'text' },
    { label: 'Phone Number', fieldName: 'Phone', type: 'phone' }
];

export default class AccountDataTable extends LightningElement {
    accountData = [];
    columns = COLUMNS;
    selectedRows = [];

    @wire(getListUi, { objectApiName: ACCOUNT_OBJECT, listViewApiName: 'All' })
    wiredAccounts({ error, data }) {
        if (data) {
            this.accountData = data.records.records.map((record) => {
                return {
                    selected: false,
                    Id: record.id,
                    Name: record.fields.Name.value,
                    Rating: record.fields.Rating.value,
                    Phone: record.fields.Phone.value
                };
            });
        } else if (error) {
            console.error('Error loading account records:', error);
        }
    }

    
}