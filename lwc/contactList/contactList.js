import { LightningElement ,wire,api} from 'lwc';
//import getContacts from '@salesforce/apex/Accountdetail.getContacts';
export default class ContactList extends LightningElement {
   
 @api contacts;

 /*   @wire(getContacts, { field1: 'Name', field2: 'Email', field3: 'AccountName' })
    wiredContacts({ error, data }) {
        if (data) {
            this.contacts = data;
            console.log('contacts@@@',data);
        } else if (error) {
            console.error(error);
        }
    } */
 handleBackClick() {
        // Dispatch a custom event when the back button is clicked
        const event = new CustomEvent('backclick');
        this.dispatchEvent(event);
    }
}