import { LightningElement, api } from 'lwc';
import createAccount from '@salesforce/apex/AccountCreationDemo.createAccount';

export default class HelloComponentForVFLWC extends LightningElement {
    @api inputValue; // Public property to accept input from VF page

    @api
    myMethod() {
        console.log('Method called from Visualforce page');
        console.log('Received input value:', this.inputValue);

        // Call the Apex method to create an Account
        createAccount()
            .then(() => {
                console.log('Account created successfully.');
            })
            .catch(error => {
                console.error('Error creating Account:', error.body.message);
            });
    }
}