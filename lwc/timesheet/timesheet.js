import { LightningElement, wire, track } from 'lwc';
import getTimesheetData from '@salesforce/apex/Timesheet.getTimesheetData';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex,} from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    { label: 'Date', fieldName: 'Date__c', type: 'date' },
    {
        label: 'Hours Logged',
        fieldName: 'Hours_Logged__c',
        type: 'number',
        editable: true, 
        typeAttributes: { type: 'number', step: '0.01', }, 
        
    },
];

export default class TimesheetTable extends LightningElement {
    columns = columns;
    @track timesheetData = [];
    @track error;
 @track wiredResponse;
    @wire(getTimesheetData)
    wiredTimesheetData(response) {
          this.wiredResponse = response;
        if (response.data) {
            this.timesheetData =response.data.map(record => ({
                ...record,
                Hours_Logged__c: parseFloat(record.Hours_Logged__c),
            }));
        } else if (response.error) {
            this.error = response.error;
        }
    }

    handleSave(event) {
        const updatedFields = event.detail.draftValues.map(draft => {
            const { Id, Hours_Logged__c } = draft;
            console.log('Updated Field:', Id, Hours_Logged__c); 
            return { fields: { Id, Hours_Logged__c } };
        });

        // Update records with the new values
        const promises = updatedFields.map(field => updateRecord(field));

        Promise.all(promises)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Records updated successfully',
                        variant: 'success',
                    })
                    
                );
                // Clear draft values to remove the save/cancel buttons
                
                this.template.querySelector('lightning-datatable').draftValues = [];
                 return refreshApex(this.wiredResponse);
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Error updating records',
                        variant: 'error',
                    })
                );
               
                console.error('Error updating records:', error);
                
            });
    }
}