import { LightningElement, track } from 'lwc';
import saveRecord from '@salesforce/apex/RecordController.saveRecord';
import updateRecord from '@salesforce/apex/RecordController.updateRecord';
import deleteRecord from '@salesforce/apex/RecordController.deleteRecord';

export default class CreateUpdateDeleteRecordComponent extends LightningElement {
    @track customerId = ''; // For update and delete
    @track customerName = '';
    @track email = '';
    @track mobile = '';
    @track status = '';

    CustomerStatus = [
        { label: 'Active', value: 'Active' },
        { label: 'Inactive', value: 'Inactive' },
    ];

    get options() {
        return this.CustomerStatus;
    }

    handleInputChange(event) {
        const field = event.target.label;
        if (field === 'Customer Name') {
            this.customerName = event.target.value;
        } else if (field === 'Email') {
            this.email = event.target.value;
        } else if (field === 'Mobile') {
            this.mobile = event.target.value;
        }
    }

    handleStatusChange(event) {
        this.status = event.detail.value;
    }

    handleSave() {
        const fields = {
            Id : this.customerId,
            CustomerName: this.customerName,
            Email: this.email,
            Mobile: this.mobile,
            Status: this.status
        };

        if (this.customerId) {
           
            fields.Id = this.customerId;
            console.log('Updating record:', fields);

            updateRecord({ record: fields })
                .then(result => {
                    console.log('Record updated:', result);
                    this.resetForm();
                })
                .catch(error => {
                    console.error('Error updating record:', error);
                });
        } else {
            // If customerId is not present, create the record
            console.log('Saving record:', fields);

            saveRecord({ record: fields })
                .then(result => {
                    console.log('Record saved:', result);
                    this.customerId = result;
                    this.resetForm();
                })
                .catch(error => {
                    console.error('Error saving record:', error);
                });
        }
    }

    handleDelete() {
        // if (!this.customerId) {
        //     console.error('No customerId to delete');
        //     return;
        // }

        console.log('Deleting record:', this.customerId);

        deleteRecord({ recordId: this.customerId })
            .then(result => {
                console.log('Record deleted:', result);
                this.resetForm();
            })
            .catch(error => {
                console.error('Error deleting record:', error);
            });
    }

    resetForm() {
        this.customerId = '';
        this.customerName = '';
        this.email = '';
        this.mobile = '';
        this.status = '';
    }
}