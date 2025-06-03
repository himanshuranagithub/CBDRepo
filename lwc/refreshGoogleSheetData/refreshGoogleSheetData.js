import { LightningElement } from 'lwc';
import refreshData from '@salesforce/apex/GoogleSheetIntegration.refreshData';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class RefreshGoogleSheetData extends LightningElement {
    handleRefresh() {
        console.log('Starting refresh from Google Sheet...');
        refreshData()
            .then((result) => {
                console.log('Data refresh successful:', result);
                this.showToast('Success', 'Data refreshed from Google Sheet.', 'success');
            })
            .catch(error => {
                console.error('Error during data refresh:', error);
                this.showToast(
                    'Error',
                    error?.body?.message || error?.message || 'Something went wrong',
                    'error'
                );
            });
    }

    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(evt);
    }
}