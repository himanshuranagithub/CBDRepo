import { LightningElement, wire, track,api } from 'lwc';
import { refreshApex,} from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import fetchAccounts from '@salesforce/apex/Accountdetail.fetchAccounts';
import sendEmails from '@salesforce/apex/Accountdetail.sendEmails';
import deleteAccounts from '@salesforce/apex/Accountdetail.deleteAccounts';
import getAccounts from '@salesforce/apex/Accountdetail.getAccounts';
export default class Accountdeatil extends NavigationMixin(LightningElement) {
     @api
    accountId;
    @api selectedIds;
       @track showForm = false;
    @track accountId;
@track searchKey = '';

  @track accounts = []; // Initialize this with your account data
    @track currentPage = 1;
    pageSize = 10;
 @track displayedAccounts =[];
  
    @track filteredAccounts = [];

    @wire(getAccounts) accounts;
     @track showForm = false;

    handleCreateNewAccount() {
        this.showForm = true;
    }

    closeCreateForm() {
        this.showForm = false;
    }

    openCreateForm() {
        this.showForm = true;
    }

    handleSucces(event) {
        const accountId = event.detail.id;

        if (accountId) {
            this.accountId = accountId;
            this.showForm = false; 
            const toastEvent = new ShowToastEvent({
            title: 'Success',
            message: 'Account created successfully',
            variant: 'success'
            
        });
       
        this.dispatchEvent(toastEvent);
         return refreshApex(this.wiredResponse);
        } else {
            console.error('Account creation failed:', event.detail);
        }
    }

    refreshData() {
        getAccounts()
            .then(result => {
                this.updatePagedAccounts = result;
            })
            .catch(error => {
                console.error('Error fetching accounts:', error);
            });
    }

    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Email', fieldName: 'email__c' },
        { label: 'Phone', fieldName: 'Phone' },
        { label: 'Actions', type: 'button', typeAttributes: { label: 'Edit', name: 'edit' } },
    ];

   
    @track wiredResponse;
   @track isEditFormOpen = false;
    @track editedRecordId;
    @track editedRecord = {};
     searchInput;

    @wire(fetchAccounts, { field1: 'Name', field2: 'email__c', field3: 'Phone' })
    wiredAccountData(response) {
        this.wiredResponse = response;
        
        if (response.data) {
            this.accounts = response.data;
             this.updatePagedAccounts();
            
        } else if (response.error) {
            console.error(response.error);
        }
    }

   handleRowSelection(event) {
    this.selectedIds = event.detail.selectedRows.map(row => row.Id);
    console.log('thisselectedid: ' + this.selectedIds);
    this.disableDeleteButton = this.selectedIds.length === 0;
}


  /*deleteSlected() {
    if (this.selectedIds.length === 0) {
        // Display a message to the user indicating that they need to select records.
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: 'Please select at least one record to delete.',
                variant: 'error'
            })
        );
        return; // Exit the function without performing any deletions.
    }

    // If there are selected records, proceed with the delete operation.
    Promise.all(
        this.selectedIds.map(accountId => deleteRecord(accountId))
    )
    .then(() => {
        this.selectedIds = [];
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Records deleted successfully.',
                variant: 'success'
            })
        );
        return refreshApex(this.wiredResponse);
    })
    .catch(error => {
        console.error(error);
    });
}*/

handleButtonClick (){
    debugger;
     console.log('thisselectedid: ' + this.selectedIds);
    if (this.selectedIds && this.selectedIds.length > 0) {
        deleteAccounts({ accountIds:this.selectedIds })
            .then(result => {
                console.log(result);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Delete successfully.',
                        variant: 'success'
                    })
                );
                return refreshApex(this.wiredResponse);
            })
            .catch(error => {
                console.error(error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'An error occurred while delete the record.',
                        variant: 'error'
                    })
                );
                
            });
    } 
    else {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: 'Please select at least one account to delete.',
                variant: 'error'
            })
        );
    }
}

    

   sendEmail() {
    if (this.selectedIds && this.selectedIds.length > 0) {
        sendEmails({ accountIds: this.selectedIds })
            .then(result => {
                console.log(result);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Email successfully sent.',
                        variant: 'success'
                    })
                );
                return refreshApex(this.wiredResponse);
            })
            .catch(error => {
                console.error(error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'An error occurred while sending the email.',
                        variant: 'error'
                    })
                );
                
            });
    } else {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: 'Please select at least one account to send an email.',
                variant: 'error'
            })
        );
    }
}


   handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        if (actionName === 'edit') {
            this.openEditForm(row.Id);
        }
    }
  
    openEditForm(recordId) {
        this.isEditFormOpen = true;
        this.editedRecordId = recordId;
    }

   closeEditForm() {
        this.isEditFormOpen = false;
        this.editedRecordId = null;
        this.editedRecord = {};
    }


handleSuccess(event) {
    if (event.detail.id) {
        // Record was updated, show success message
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Record updated successfully.',
                variant: 'success'
            })
        );
        this.isEditFormOpen = false;
        this.editedRecordId = '';
        refreshApex(this.wiredResponse);
    } else {
        // Record was not updated, do not show the success message
        this.isEditFormOpen = false;
        this.editedRecordId = '';
    }
}
  

    handleError() {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: 'An error occurred while updating the record.',
                variant: 'error'
            })
        );
    }
     get accounts() {
        return this.accounts.filter(account => {
            return account.Name.toLowerCase().includes(this.searchTerm.toLowerCase());
        });
    }

   
   handleSearch(event) {
        this.searchKey = event.target.value;
    }

    @wire(getAccounts, { searchKey: '$searchKey' })
    wiredAccounts({ data, error }) {
        if (data) {
            this.displayedAccounts = data;
        } else if (error) {
            console.error(error);
        }
    }
 
    fetchContacts() {
    if (this.selectedIds && this.selectedIds.length > 0) {
        const fetchContactsEvent = new CustomEvent('fetchcontacts', {
            detail: this.selectedIds
        });
        this.dispatchEvent(fetchContactsEvent);

        console.log('Custom event "fetchcontacts" dispatched with account IDs:', this.selectedIds);
    } else {
        // Display a message to the user indicating that they need to select accounts.
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: 'Please select at least one account to fetch contacts.',
                variant: 'error'
            })
        );
    }
}

 handlePrevious(event) {
    if (this.currentPage > 1) {
        this.currentPage -= 1;
        this.updatePagedAccounts();
        console.log('Previous Page: ', this.currentPage);
    }
}

     handleNext(event) {
        if (this.currentPage < this.totalPages) {
            this.currentPage += 1;
            this.updatePagedAccounts();
            console.log('Next Page: ', this.currentPage);
        }
    }

    updatePagedAccounts() {
        const start = (this.currentPage - 1) * this.pageSize;
        const end = start + this.pageSize;
        this.displayedAccounts = this.accounts.slice(start, end);
        console.log('Current Page: ', this.currentPage);
        console.log('Displayed Accounts: ', this.displayedAccounts);
    }

    get totalPages() {
        return Math.ceil(this.accounts.length / this.pageSize);
    }


}