import { LightningElement, api } from 'lwc';

export default class ChildComponentC extends LightningElement {
    @api message;

    handleClick() {
        const event = new CustomEvent('message', {
            detail: { message: 'Hello from Child' }
        });
        this.dispatchEvent(event);
    }
}