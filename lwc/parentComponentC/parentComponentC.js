import { LightningElement, track } from 'lwc';

export default class ParentComponent extends LightningElement {
    parentMessage = 'Hello from Parent';
    @track childMessage;

    handleMessage(event) {
        this.childMessage = event.detail.message;
    }
}