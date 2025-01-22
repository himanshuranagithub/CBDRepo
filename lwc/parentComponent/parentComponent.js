import { LightningElement, track } from 'lwc';

export default class ParentComponent extends LightningElement {
    @track childMessage = 'Hello, World Parent!';
    @track newMessage = '';

    handleNewMessageChange(event) {
        this.newMessage = event.target.value;
    }

    handleUpdateMessage() {
        const childComponent = this.template.querySelector('c-my-component');
        if (childComponent) {
            childComponent.updateMessage(this.newMessage);
        }
    }
}