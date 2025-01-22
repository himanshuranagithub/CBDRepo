import { LightningElement, track } from 'lwc';
import saveCsvData from '@salesforce/apex/CsvFileUploadController.saveCsvData'; // Import Apex method

export default class CsvFileUpload extends LightningElement {
    @track parsedData = [];
    @track saveMessage = '';
    saveMessageClass = '';
    error = '';
    
    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Value', fieldName: 'Value' }
    ];

    handleFileUpload(event) {
        this.error = '';
        this.saveMessage = '';
        const file = event.target.files[0];

        if (file && file.type === 'text/csv') {
            console.log('CSV file detected');
            this.parseCsv(file);
        } else {
            this.error = 'Invalid file format. Please upload a CSV file.';
        }
    }

    parseCsv(file) {
        const reader = new FileReader();

        reader.onload = () => {
            const text = reader.result;
            if (text) {
                console.log('File content read successfully:', text);
                this.parsedData = this.convertCsvToArray(text);
            } else {
                this.error = 'Failed to read file content.';
            }
        };

        reader.onerror = () => {
            this.error = 'Error reading file. Please try again.';
        };

        reader.readAsText(file);
    }

    convertCsvToArray(csv) {
        const [header, ...rows] = csv.split('\n');
        const headers = header.split(',');

        const data = rows.map((row, index) => {
            const values = row.split(',');

            return {
                id: index,
                Name: values[0].trim(),
                Value: values[1].trim()
            };
        });

        console.log('Parsed CSV Data:', data);
        return data;
    }

    // Save parsed data to Salesforce
    handleSave() {
        saveCsvData({ csvData: this.parsedData })
            .then((result) => {
                this.saveMessage = 'Data saved successfully!';
                this.saveMessageClass = 'slds-text-color_success';
                this.parsedData = [];
            })
            .catch((error) => {
                this.saveMessage = 'Error saving data: ' + error.body.message;
                this.saveMessageClass = 'slds-text-color_error';
            });
    }
}