import { LightningElement } from 'lwc';
import Image_Url from '@salesforce/resourceUrl/renewal_reminder';

export default class RenewalReminder extends LightningElement {

    cbd_app_logo = Image_Url + '/renewal_reminder/cbd_app_logo.png';
  
   handleRenew() {
     
        // Logic to handle renew button click event
         window.open('https://www.cbdapp.in/', '_blank');
    }
}