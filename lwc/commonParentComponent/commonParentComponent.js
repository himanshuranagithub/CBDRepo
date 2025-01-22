import { LightningElement, track } from 'lwc';

export default class CommonParentComponent extends LightningElement {
    @track sharedMessage = '';

    handleMessageChange(event) {
        this.sharedMessage = event.detail.message;
    }
}