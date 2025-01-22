import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import COUNTER_MESSAGE_CHANNEL from '@salesforce/messageChannel/CounterMessageChannel__c';

export default class CounterSubscriber extends LightningElement {
    value = 0;
    subscription = null;

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    subscribeToMessageChannel() {
        if (this.subscription) {
            return;
        }
        this.subscription = subscribe(this.messageContext, COUNTER_MESSAGE_CHANNEL, (message) => {
            this.handleMessage(message);
        });
    }

    handleMessage(message) {
        this.value = message.value;
    }

    disconnectedCallback() {
        if (this.subscription) {
            this.subscription.unsubscribe();
            this.subscription = null;
        }
    }
}