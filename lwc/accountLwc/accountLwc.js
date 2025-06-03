import { LightningElement, track, wire } from 'lwc';
import getAccount from '@salesforce/apex/AccountLwc.getAccount';
import deleteAccount from '@salesforce/apex/AccountLwc.deleteAccount';
export default class AccountCreateEditDelete extends LightningElement {
    @track AccCollection;
    @track accids = []
    istrue = false;
    fields = ['Name','Phone','Type','Fax'];
    HandleCreate(){
        this.istrue = true;
    }
    handleSuccess(){
        this.istrue = false;
    }
    actions = [
        { label: 'Edit', name: 'edit' },
        { label: 'Delete', name: 'delete' }
    ];
    cols = [
        { label: 'Name', fieldName: 'Name', type: 'text' , editable:true},
        { label: 'Phone', fieldName: 'phone', type: 'phone' },
        { label: 'Fax', fieldName: 'Fax', type: 'text' },
        { label: 'Type', fieldName: 'Type', type: 'text' },
        {
            label: 'Edit',
            type: 'button',
            initialWidth: 135,
            typeAttributes: {
                label: 'Edit',
                name: 'edit',
                title: 'Edit',
                variant: 'brand'
            }
        },
        {
            label: 'Delete',
            type: 'button',
            initialWidth: 135,
            typeAttributes: {
                label: 'Delete',
                name: 'delete',
                title: 'Delete',
                variant: 'destructive'
            }
        }
    ];
    @wire(getAccount)
    accountfunction({data,error}){
      if(data){
         this.AccCollection = data;
         console.log(data);
      }if(error){
          console.error(error);
      }
    }
    handleEdit(event) {
        const accountId = event.target.dataset.id; // Get the Account Id from the button
        console.log('Edit clicked for Account Id:', accountId);
        // Implement logic for editing an Account record (e.g., navigate to edit page)
    }

    handleDelete(event) {
        const accountId = event.target.dataset.id; // Get the Account Id from the button
        console.log('Delete clicked for Account Id:', accountId);
        // Implement logic for deleting an Account record (e.g., show confirmation modal)
    }
    handleRowAction(event) {
        const action = event.detail.action;
        const row = event.detail.row;

        switch (action.name) {
            case 'edit':
                this.handleEdit(row);
                break;
            case 'delete':
                this.handleDelete(row);
                break;
            // Add more cases for other actions if needed
            default:
                break;
        }
    }

    handleEdit(row) {
        console.log('Edit clicked for Account Id:', row.Id);
        // Implement logic for editing an Account record (e.g., navigation to edit page)
        row.editable = false;

        // Perform any other operations for editing as needed
        console.log('Edit clicked for Account Id:', row.Id);
        console.log('Editable:', row.editable);
    }

    handleDelete(row){
        console.log('Delete clicked for Account Id:', row.Id);
        // Implement logic for deleting an Account record (e.g., show confirmation modal)
        const accid = row.Id;
        const accidslist = null;
        deleteAccount({AccountId:accid, Accountids:accidslist})
        .then(result=>{
            console.log('success')
        }).catch(error=>{
            console.log('Error')
        });    
    }
    deleteMultiple(){
        console.log('check the accounts')
        const selectedRows = this.template.querySelector('lightning-datatable').getSelectedRows();
        console.log(selectedRows);
        const accid = null;
        this.accids = [];
        let accidsarr = []; 
        let arrayofAccids 
        selectedRows.forEach(singleAccount => {
            console.log(singleAccount);
            console.log(singleAccount.Id);
            this.accids.push(singleAccount.Id);
        });
         console.log('string of Ids ----> ' + JSON.stringify(this.accids))
         arrayofAccids = this.accids.join(',');
        console.log(arrayofAccids);
        deleteAccount({AccountId:accid, AccountIds:arrayofAccids})
        .then(result=>{
            console.log('success')
        }).catch(error=>{
            console.log('Error')
        }); 
      
    
   }
}