import { LightningElement, api } from 'lwc';

export default class MyComponent extends LightningElement {
   
     @api message = 'Hello, World child!';

   
     @api updateMessage(newMessage) {
        this.message = newMessage;
    }
}