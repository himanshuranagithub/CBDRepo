import { LightningElement, track } from 'lwc';
import getAccountData from '@salesforce/apex/SearchAccountController.getAccountData';

export default class SearchAccountData extends LightningElement {
    @track keySearch = '';
    @track accounts;
    @track error;
    // @wire(getAccountData, { searchKey: '$keySearch' })accounts;

    //    @wire(getAccountData,{keySearch : '$keySearch'})
    //    wireAccount({data,error}){
    //         if(data){
    //             this.accounts=data;
    //             this.error=undefined;
    //         }else{
    //             this.accounts=undefined;
    //             this.error=error;
    //         }
    //    }
    //   
    handleData() {
        getAccountData({ searchKey: this.keySearch })
            .then(result => {
                this.accounts = result;
                this.error = undefined;
            })
            .catch(error => {
                this.accounts = undefined;
                this.error = error.body.message;
            });
    }

    handleChange(event) {
        this.keySearch = event.target.value;
        this.handleData();  // Fetch the data whenever the search key changes
    }
}