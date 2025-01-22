import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class MyFirstLwc extends LightningElement {
    myTitle = "Hello World";

    // connectedCallback(){
    //     var name = "Salesforce Devloper";
    //     alert("name"+name);
    // }
    handleClick(){
        this.showToast();
    }
    showToast(){
        const event = new ShowToastEvent({
        title: 'Show toast demo',
        message: 'Want to display toast example',
        varient: 'success',
        })
        this.dispatchEvent(event);
    }
}