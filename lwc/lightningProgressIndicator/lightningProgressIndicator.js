import { LightningElement, track } from 'lwc';
export default class LightningProgressIndicator extends LightningElement {

    @track currentStep = '1'; // Initial step
    totalSteps = 3; // Total number of steps
    completedSteps = new Set(); // Set to keep track of completed steps

    handleStepClick(event) {
        const selectedStep = event.target.dataset.step;
        if (selectedStep) {
            this.currentStep = selectedStep;
            this.markStepAsCompleted(selectedStep);
        }
    }

    markStepAsCompleted(step) {
        this.completedSteps.add(step);
    }

    get deploymentStepClass() {
        if (this.currentStep === '3') {
            return 'green-step slds-progress__marker slds-progress__marker_complete';
        } else {
            return this.completedSteps.has('3') ? 'slds-progress__marker slds-progress__marker_complete' : '';
        }
    }


}