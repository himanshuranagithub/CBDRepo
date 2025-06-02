import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/accountRecordController.getAccounts';

export default class AccountRecord extends LightningElement {
    accountList = [];
    selectedAccounts = new Set(); // Use a Set to store selected account IDs

    @wire(getAccounts)
    wiredAccounts({ data, error }) {
        if (data) {
            // Limit to the first 10 records
            this.accountList = data.slice(0, 10);
        } else if (error) {
            // Handle error
        }
    }

    handleSelectAll(event) {
        const checkboxes = this.template.querySelectorAll('input[type="checkbox"]');
        checkboxes.forEach((checkbox) => {
            checkbox.checked = event.target.checked;
            if (event.target.checked) {
                // Add all IDs to selectedAccounts when "Select All" is checked
                this.accountList.forEach((account) => {
                    this.selectedAccounts.add(account.Id);
                });
            } else {
                // Clear selectedAccounts when "Select All" is unchecked
                this.selectedAccounts.clear();
            }
        });
    }

    handleCheckboxChange(event) {
        const accountId = event.target.getAttribute('data-id');
        const isChecked = event.target.checked;

        if (isChecked) {
            // Add the selected account ID to the selectedAccounts Set
            this.selectedAccounts.add(accountId);
        } else {
            // Remove the unselected account ID from the selectedAccounts Set
            this.selectedAccounts.delete(accountId);
        }
    }
}