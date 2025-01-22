import { LightningElement, api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';

export default class LightningRecordEditFormDemo extends LightningElement {
    nameField = NAME_FIELD;
    phoneField = PHONE_FIELD;

    @api recordId;
    connectedCallback() {
        console.log('recordId'+recordId);
    }
    @api objectApiName = 'Contact'; // Default to Contact object if not set by parent
}