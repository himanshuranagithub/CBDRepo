import { LightningElement, track } from 'lwc';
import scheduleDeployment from '@salesforce/apex/DeploymentSchedulerController.scheduleDeployment';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DeploymentScheduler extends LightningElement {
    @track packages = [
        { Id: '001', PackageName: 'Package A', Status: 'Validated', ScheduledTime: '', isScheduled: false, showDatePicker: false, JobCompletionStatus: 'Not Started', DeploymentResult: '', displayScheduledTime: 'Not Scheduled', disabled: false, actionLabel: 'Schedule Deployment' },
        { Id: '002', PackageName: 'Package B', Status: 'Validated', ScheduledTime: '', isScheduled: false, showDatePicker: false, JobCompletionStatus: 'Not Started', DeploymentResult: '', displayScheduledTime: 'Not Scheduled', disabled: false, actionLabel: 'Schedule Deployment' },
        { Id: '003', PackageName: 'Package C', Status: 'Validated', ScheduledTime: '', isScheduled: false, showDatePicker: false, JobCompletionStatus: 'Not Started', DeploymentResult: '', displayScheduledTime: 'Not Scheduled', disabled: false, actionLabel: 'Schedule Deployment' }
    ];


    connectedCallback() {
        // Compute displayScheduledTime, disabled and actionLabel properties
        this.packages = this.packages.map(pkg => ({
            ...pkg,
            displayScheduledTime: pkg.ScheduledTime ? pkg.ScheduledTime : 'Not Scheduled',
            disabled: this.computeDisabled(pkg),
            actionLabel: this.computeActionLabel(pkg)
        }));
    }

    computeDisabled(pkg) {
        // Disable the button if the status is 'Deployed' or the job is not completed
        return pkg.Status === 'Deployed' || pkg.JobCompletionStatus !== 'Completed';
    }

    computeActionLabel(pkg) {
        // Compute the action button label based on the package status
        if (pkg.Status === 'Scheduled') {
            return 'Deploy Now';
        } else if (pkg.Status === 'Failed') {
            return 'Retry Deployment';
        }
        return 'Schedule Deployment';
    }

    @track isLoading = false;

   handleScheduleClick(event) {
        const packageId = event.target.dataset.id;  // Get package id from data-id
        const selectedPackage = this.packages.find(pkg => pkg.Id === packageId);

        // Show the date picker and update the status to "Scheduled"
        selectedPackage.showDatePicker = true;
        selectedPackage.Status = 'Scheduled';  // Change status to Scheduled
        selectedPackage.actionLabel = 'Deploy Now'; // Update action label

        // Update the packages array to trigger reactivity
        this.packages = [...this.packages]; // Reassign array to trigger rendering
    }

    handleDateChange(event) {
        const packageId = event.target.dataset.id;  // Get package id from data-id
        const selectedPackage = this.packages.find(pkg => pkg.Id === packageId);

        // Update the ScheduledTime based on user selection
        selectedPackage.ScheduledTime = event.target.value;
        selectedPackage.displayScheduledTime = selectedPackage.ScheduledTime;

        // Enable the "Deploy Now" button if a date and time are selected
        if (selectedPackage.ScheduledTime) {
            selectedPackage.disabled = false;
        }

        // Update the packages array to trigger reactivity
        this.packages = [...this.packages]; // Reassign array to trigger rendering
    }

    handleDeployClick(event) {
        const packageId = event.target.dataset.id;  // Get package id from data-id
        const selectedPackage = this.packages.find(pkg => pkg.Id === packageId);

        // Simulate deployment process
        selectedPackage.JobCompletionStatus = 'Completed';
        selectedPackage.DeploymentResult = 'Success'; // You can set this dynamically based on real result
        selectedPackage.Status = 'Deployed'; // Change status to Deployed
        selectedPackage.actionLabel = 'Deployment Completed'; // Update button label

        // Update the packages array to trigger reactivity
        this.packages = [...this.packages]; // Reassign array to trigger rendering
    }


    // Schedule the package and update its status
    schedulePackage(selectedPackage) {
        this.isLoading = true;
        scheduleDeployment({ packageId: selectedPackage.Id, scheduledTime: selectedPackage.ScheduledTime })
            .then(() => {
                selectedPackage.Status = 'Scheduled';
                selectedPackage.isScheduled = true;
                selectedPackage.showDatePicker = false;
                selectedPackage.JobCompletionStatus = 'In Progress';
                this.showToast('Success', 'Deployment Scheduled Successfully', 'success');
                this.isLoading = false;
            })
            .catch(error => {
                this.showToast('Error', 'Error scheduling deployment', 'error');
                this.isLoading = false;
            });
    }

    // Simulate the deployment process
    deployPackage(selectedPackage) {
        this.isLoading = true;

        // Simulate deployment process
        setTimeout(() => {
            // Here we simulate a successful deployment. You can modify this logic as per actual deployment result.
            const isSuccess = Math.random() > 0.2; // 80% chance of success

            selectedPackage.Status = 'Deployed';
            selectedPackage.JobCompletionStatus = 'Completed';
            selectedPackage.DeploymentResult = isSuccess ? 'Success' : 'Failed';
            selectedPackage.ScheduledTime = new Date().toLocaleString(); // Set deployment time to now

            this.showToast(
                'Success',
                `Package ${isSuccess ? 'Deployed Successfully' : 'Deployment Failed'}`,
                isSuccess ? 'success' : 'error'
            );

            this.isLoading = false;
        }, 3000); // Simulate a 3-second deployment time
    }

    // Show toast notification
    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: variant
            })
        );
    }
}