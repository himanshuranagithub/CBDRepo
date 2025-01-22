import { LightningElement, track, api } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import ID_FIELD from '@salesforce/schema/Contact.Id';

export default class InlineEditDataTable extends LightningElement {
    @api records = []; // Array to hold the contact records
    @track columns = [
        { label: 'Name', fieldName: 'Name', editable: true },
        { label: 'Phone', fieldName: 'Phone', editable: true }
    ];

    // Sample data - Replace this with actual data retrieval
    connectedCallback() {
        this.records = [
            { Id: '0031t00000HsU3aAAF', Name: 'John Doe', Phone: '555-555-5555' },
            { Id: '0031t00000HsU3bAAF', Name: 'Jane Smith', Phone: '555-555-5556' }
        ];
    }

    handleSave(event) {
        const updatedFields = event.detail.draftValues.map(draft => ({
            fields: { ...draft }
        }));

        const promises = updatedFields.map(record => 
            updateRecord(record)
        );

        Promise.all(promises)
            .then(() => {
                // Handle success
                this.showToast('Success', 'Records updated successfully', 'success');
            })
            .catch(error => {
                // Handle error
                this.showToast('Error', 'Error updating records', 'error');
            })
            .finally(() => {
                // Clear draft values after save
                this.draftValues = [];
            });
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(event);
    }
}