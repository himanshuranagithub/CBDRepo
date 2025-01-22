import { LightningElement, track } from 'lwc';

export default class CounterComponent extends LightningElement {
    students = [
        { id: 1, name: 'John' },
        { id: 2, name: 'Jane' },
    ];

    addStudent() {
        this.students.push({ id: 3, name: 'Jake' });
        // Without @track, the component might not re-render when pushing to the array
    }
}