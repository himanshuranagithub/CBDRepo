import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import COUNTER_MESSAGE_CHANNEL from '@salesforce/messageChannel/CounterMessageChannel__c';

export default class CounterPublisher extends LightningElement {
    value = 0;

    @wire(MessageContext)
    messageContext;

    handleIncrement() {
        this.value++;
        this.publishValue();
    }

    handleDecrement() {
        this.value--;
        this.publishValue();
    }

    handleMultiply() {
        this.value *= 2;
        this.publishValue();
    }

    publishValue() {
        const message = { value: this.value };
        publish(this.messageContext, COUNTER_MESSAGE_CHANNEL, message);
    }
}