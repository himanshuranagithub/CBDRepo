import { LightningElement } from 'lwc';

export default class SiblingA extends LightningElement {
    handleInputChange(event) {
        const message = event.target.value;
        const messageEvent = new CustomEvent('messagechange', {
            detail: { message }
        });
        this.dispatchEvent(messageEvent);
    }
}