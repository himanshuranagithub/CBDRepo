import { LightningElement } from 'lwc';
export default class Firstlwccomponent extends LightningElement {
    Name ='Ram';
    Email ='ram123@gmail.com';
    Phone = '1234567890';

    aredetailsvisible = false;
    handelChange(event){
        this.aredetailsvisible = event.target.checked;
    }

}